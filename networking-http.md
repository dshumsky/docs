##### Links
- <https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/http-caching>
- <https://book.varnish-software.com/4.0/chapters/HTTP.html>

##### Response
- `ETag` - hash for resource
    - request If-None-Match = <ETag>,  response 304 (Not Modified)
- `Cache-Control` 
    - `no-store` - don't store anything in browser
    - `no-cache` - use ETag only
    - `public` - cache is allowed, `private` - disables CDN
    - `max-age` - reuse in seconds
    - `Expires` - deprecated

##### DNS
- dig abc.com +trace
- dig abs.com @ns30.domaincontrol.com
