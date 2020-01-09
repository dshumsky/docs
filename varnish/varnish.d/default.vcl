vcl 4.0;

import std;
import directors;

sub default_cache_behaviour {

    if(!beresp.http.Cache-Control) {
      std.log("WARN: Empty Cache-Control header for URL: " + bereq.url);
      set beresp.http.X-Varnish-Cacheable = "true";
      set beresp.http.Cache-control = "public, max-age=60, s-maxage=60";
      set beresp.ttl = 1m;
    }

    if(beresp.http.Cache-Control ~ "no-store|no-cache") {
        set beresp.ttl = 0s;
    }

    if(beresp.ttl > 0s && beresp.ttl < 1s) {
        set beresp.ttl = 0s;
    }

    if(beresp.ttl > 0s) {
        set beresp.http.X-Varnish-Age = "";
        set beresp.grace = 1m;
        unset beresp.http.Set-Cookie;
        set beresp.http.X-Varnish-Cacheable = "true";
    } else {
        set beresp.http.Expires = now;
        set beresp.http.Cache-Control = "no-store";
        set beresp.http.X-Varnish-Cacheable = "false";
        set beresp.uncacheable = true;
        set beresp.ttl = 120s;
    }
}


backend nodejs {
    .host = "nodejs-server";
    .port = "8080";
    .first_byte_timeout = 15s;
    .between_bytes_timeout = 15s;
}

sub vcl_init {
    # new rr = directors.round_robin();
    # rr.add_backend(1);
    # rr.add_backend(2);
}

sub vcl_recv {

    if (req.method != "GET" &&
        req.method != "HEAD" &&
        req.method != "PUT" &&
        req.method != "PATCH" &&
        req.method != "DELETE" &&
        req.method != "OPTIONS" &&
        req.method != "POST" ) {
        return (synth(405, "Only Get, Head, Options, Delete, Patch nad Post allowed"));
    }

    if (req.url ~ "^\/cache\/") {
        set req.backend_hint = nodejs;
        unset req.http.Cookie;
        return (hash);
    }

    return(synth(404));
}

sub vcl_pipe {
    set bereq.http.Connection = "close";
}

sub vcl_pass {
}

sub vcl_hash {
}

sub vcl_hit {
}

sub vcl_miss {
}

sub vcl_backend_fetch {
}

sub vcl_backend_response {
    set beresp.do_esi = true;
    unset beresp.http.etag;
    call default_cache_behaviour;
    return (deliver);
}

sub vcl_deliver {
    if (obj.hits > 0) {
        set resp.http.X-Varnish-Action = "hit";
        set resp.http.X-Varnish-Hits = obj.hits;
    } else {
        set resp.http.X-Varnish-Action = "miss";
    }
    if (resp.http.X-Varnish-Age) {
        set resp.http.X-Varnish-Age = resp.http.Age;
        set resp.http.Age = "0";
    }

    if (req.http.X-Debug) {
        set resp.http.X-Debug = req.http.X-Debug;
    }
}
