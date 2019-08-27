nginx base
-----------

```bash
[root@fbff25bd10aa /]# ll /etc/nginx/
total 40
drwxr-xr-x 2 root root 4096 Aug 27 22:07 conf.d
-rw-r--r-- 1 root root 1007 Aug 13 14:01 fastcgi_params
-rw-r--r-- 1 root root 2837 Aug 13 14:01 koi-utf
-rw-r--r-- 1 root root 2223 Aug 13 14:01 koi-win
-rw-r--r-- 1 root root 5231 Aug 13 14:01 mime.types
lrwxrwxrwx 1 root root   29 Aug 27 22:07 modules -> ../../usr/lib64/nginx/modules
-rw-r--r-- 1 root root  643 Aug 13 13:59 nginx.conf
-rw-r--r-- 1 root root  636 Aug 13 14:01 scgi_params
-rw-r--r-- 1 root root  664 Aug 13 14:01 uwsgi_params
-rw-r--r-- 1 root root 3610 Aug 13 14:01 win-utf

```


```bash
[root@fbff25bd10aa /]# cat /etc/nginx/nginx.conf 

user  nginx;
worker_processes  1;

error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    keepalive_timeout  65;

    #gzip  on;

    include /etc/nginx/conf.d/*.conf;
}
```


```
curl -v http://localhost:8085/
*   Trying ::1...
* TCP_NODELAY set
* Connected to localhost (::1) port 8085 (#0)
> GET / HTTP/1.1
> Host: localhost:8085
> User-Agent: curl/7.54.0
> Accept: */*
> 
< HTTP/1.1 200 OK
< Server: nginx/1.17.3
< Date: Tue, 27 Aug 2019 22:15:29 GMT
< Content-Type: text/html
< Content-Length: 22
< Last-Modified: Tue, 27 Aug 2019 21:38:28 GMT
< Connection: keep-alive
< ETag: "5d65a2d4-16"
< Accept-Ranges: bytes
< 
<h1>
nginx-base
</h1>
* Connection #0 to host localhost left intact
```
