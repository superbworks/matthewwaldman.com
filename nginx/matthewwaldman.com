server {
  listen       80;
  server_name  www.matthewwaldman.com;
  return       301 $scheme://matthewwaldman.com$request_uri;
}

server {
  client_max_body_size 10M;
  listen 80;
  server_name matthewwaldman.com 45.55.235.136;

  location ~* /apple-touch-icon.*\.png {
    access_log off;
    log_not_found off;
    expires 1y;
    alias /home/deployer/matthewwaldman.com/static/img/apple-touch-icon.png;
  }

  location /favicon.ico {
    access_log off;
    log_not_found off;
    expires 1y;
    alias /home/deployer/matthewwaldman.com/static/img/favicon.ico;
  }

  location / {
    auth_basic off;
    allow all;

    root /home/deployer/matthewwaldman.com;
  }
}
