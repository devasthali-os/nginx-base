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
