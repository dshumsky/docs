#### Metrics
- Check module is already enabled
     - `nginx -V 2>&1 | grep -o with-http_stub_status_module`
- Configure
```
server {
    location /nginx_status {
        stub_status;

        access_log off;
        allow 127.0.0.1;
        deny all;
    }
}
```