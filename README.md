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
```


nginx modules
-------------

```bash
[root@3d3a0c364762 /]# nginx -V
nginx version: nginx/1.17.3
built by gcc 4.8.5 20150623 (Red Hat 4.8.5-36) (GCC) 
built with OpenSSL 1.0.2k-fips  26 Jan 2017
TLS SNI support enabled
configure arguments: --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib64/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-compat --with-file-aio --with-threads --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-stream --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-cc-opt='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -m64 -mtune=generic -fPIC' --with-ld-opt='-Wl,-z,relro -Wl,-z,now -pie'
```



```bash
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

nginx access logs
-----------------

```bash
[root@3d3a0c364762 /]# tail -f /var/log/nginx/access.log
172.17.0.1 - - [28/Aug/2019:01:38:32 +0000] "GET / HTTP/1.1" 200 22 "-" "curl/7.54.0" "-"
172.17.0.1 - - [28/Aug/2019:01:38:38 +0000] "GET / HTTP/1.1" 200 22 "-" "curl/7.54.0" "-"
172.17.0.1 - - [28/Aug/2019:01:38:39 +0000] "GET / HTTP/1.1" 200 22 "-" "curl/7.54.0" "-"
172.17.0.1 - - [28/Aug/2019:01:38:47 +0000] "GET / HTTP/1.1" 304 0 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36" "-"
```

Listen Q
----------

```bash
[root@00fe41fc696a /]# netstat 
Active Internet connections (w/o servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 00fe41fc696a:http       gateway:53434           ESTABLISHED
tcp        0      0 00fe41fc696a:http       gateway:53432           ESTABLISHED
Active UNIX domain sockets (w/o servers)
Proto RefCnt Flags       Type       State         I-Node   Path
unix  3      [ ]         STREAM     CONNECTED     264606   
unix  3      [ ]         STREAM     CONNECTED     264605   
```

```
[root@00fe41fc696a /]# netstat -v  
Active Internet connections (w/o servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 00fe41fc696a:http       gateway:53438           ESTABLISHED
tcp        0      0 00fe41fc696a:http       gateway:53436           ESTABLISHED
netstat: no support for `AF INET (sctp)' on this system.
netstat: no support for `AF INET (sctp)' on this system.
Active UNIX domain sockets (w/o servers)
Proto RefCnt Flags       Type       State         I-Node   Path
unix  3      [ ]         STREAM     CONNECTED     264606   
unix  3      [ ]         STREAM     CONNECTED     264605   
netstat: no support for `AF IPX' on this system.
netstat: no support for `AF AX25' on this system.
netstat: no support for `AF X25' on this system.
netstat: no support for `AF NETROM' on this system.
```

metrics
--------

```bash
[root@a02ff83c3bf5 /]# curl localhost:9090/nginx_metrics
Active connections: 1 
server accepts handled requests
 3 3 2 
Reading: 0 Writing: 1 Waiting: 0 
```

resources
----------
- https://docs.nginx.com/nginx/admin-guide/web-server/serving-static-content/
