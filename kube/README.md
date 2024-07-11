k8s Ingress
-----------------------

- https://kubernetes.io/docs/concepts/services-networking/ingress/
- You may need to deploy an Ingress controller such as ingress-nginx. 
- You can choose from a number of Ingress controllers:https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/

```
                                                                             k8s cluster
client -------> ingress LB ---------------> [ ingress ---------> routing rules -> k8s service ---------> k8s pods ]
              (Azure, AWS LB)      
```


```bash
## taken from https://kubernetes.github.io/ingress-nginx/deploy/#aws

kubectl apply -f k8s-ingress-config.yaml
namespace/ingress-nginx created
serviceaccount/ingress-nginx created
configmap/ingress-nginx-controller created
clusterrole.rbac.authorization.k8s.io/ingress-nginx created
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx created
role.rbac.authorization.k8s.io/ingress-nginx created
rolebinding.rbac.authorization.k8s.io/ingress-nginx created
service/ingress-nginx-controller-admission created
service/ingress-nginx-controller created
deployment.apps/ingress-nginx-controller created
ingressclass.networking.k8s.io/nginx created
validatingwebhookconfiguration.admissionregistration.k8s.io/ingress-nginx-admission created
serviceaccount/ingress-nginx-admission created
clusterrole.rbac.authorization.k8s.io/ingress-nginx-admission created
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx-admission created
role.rbac.authorization.k8s.io/ingress-nginx-admission created
rolebinding.rbac.authorization.k8s.io/ingress-nginx-admission created
job.batch/ingress-nginx-admission-create created
job.batch/ingress-nginx-admission-patch created

λ kubectl get pods -n ingress-nginx
NAME                                        READY     STATUS    RESTARTS   AGE
nginx-ingress-controller-65fd579494-6jcdx   1/1       Running   0          26s

bash-5.1$ nginx -V
nginx version: nginx/1.19.9
built by gcc 10.3.1 20210424 (Alpine 10.3.1_git20210424) 
built with OpenSSL 1.1.1l  24 Aug 2021
TLS SNI support enabled
configure arguments: --prefix=/usr/local/nginx --conf-path=/etc/nginx/nginx.conf --modules-path=/etc/nginx/modules --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-debug --with-compat --with-pcre-jit --with-http_ssl_module --with-http_stub_status_module --with-http_realip_module --with-http_auth_request_module --with-http_addition_module --with-http_geoip_module --with-http_gzip_static_module --with-http_sub_module --with-http_v2_module --with-stream --with-stream_ssl_module --with-stream_realip_module --with-stream_ssl_preread_module --with-threads --with-http_secure_link_module --with-http_gunzip_module --with-file-aio --without-mail_pop3_module --without-mail_smtp_module --without-mail_imap_module --without-http_uwsgi_module --without-http_scgi_module --with-cc-opt='-g -Og -fPIE -fstack-protector-strong -Wformat -Werror=format-security -Wno-deprecated-declarations -fno-strict-aliasing -D_FORTIFY_SOURCE=2 --param=ssp-buffer-size=4 -DTCP_FASTOPEN=23 -fPIC -I/root/.hunter/_Base/d45d77d/7154e34/3b7ee27/Install/include -Wno-cast-function-type -m64 -mtune=native' --with-ld-opt='-fPIE -fPIC -pie -Wl,-z,relro -Wl,-z,now -L/root/.hunter/_Base/d45d77d/7154e34/3b7ee27/Install/lib' --user=www-data --group=www-data --add-module=/tmp/build/ngx_devel_kit-0.3.1 --add-module=/tmp/build/set-misc-nginx-module-0.32 --add-module=/tmp/build/headers-more-nginx-module-0.33 --add-module=/tmp/build/ngx_http_substitutions_filter_module-b8a71eacc7f986ba091282ab8b1bbbc6ae1807e0 --add-module=/tmp/build/lua-nginx-module-b721656a9127255003b696b42ccc871c7ec18d59 --add-module=/tmp/build/stream-lua-nginx-module-74f8c8bca5b95cecbf42d4e1a465bc08cd075a9b --add-module=/tmp/build/lua-upstream-nginx-module-8aa93ead98ba2060d4efd594ae33a35d153589bf --add-module=/tmp/build/nginx_ajp_module-a964a0bcc6a9f2bfb82a13752d7794a36319ffac --add-dynamic-module=/tmp/build/nginx-http-auth-digest-1.0.0 --add-dynamic-module=/tmp/build/nginx-influxdb-module-5b09391cb7b9a889687c0aa67964c06a2d933e8b --add-dynamic-module=/tmp/build/nginx-opentracing-0.19.0/opentracing --add-dynamic-module=/tmp/build/ModSecurity-nginx-1.0.2 --add-dynamic-module=/tmp/build/ngx_http_geoip2_module-a26c6beed77e81553686852dceb6c7fdacc5970d --add-dynamic-module=/tmp/build/ngx_brotli

kubectl logs -f nginx-ingress-controller-65fd579494-6jcdx  --namespace ingress-nginx
-------------------------------------------------------------------------------
NGINX Ingress controller
  Release:       v1.1.0
  Build:         cacbee86b6ccc45bde8ffc184521bed3022e7dee
  Repository:    https://github.com/kubernetes/ingress-nginx
  nginx version: nginx/1.19.9

-------------------------------------------------------------------------------

W1222 21:33:45.457607       8 client_config.go:615] Neither --kubeconfig nor --master was specified.  Using the inClusterConfig.  This might not work.
I1222 21:33:45.458002       8 main.go:223] "Creating API client" host="https://10.100.0.1:443"
I1222 21:33:45.477952       8 main.go:267] "Running in Kubernetes cluster" major="1" minor="21+" git="v1.21.2-eks-06eac09" state="clean" commit="5f6d83fe4cb7febb5f4f4e39b3b2b64ebbbe3e97" platform="linux/amd64"
I1222 21:33:45.673385       8 main.go:104] "SSL fake certificate created" file="/etc/ingress-controller/ssl/default-fake-certificate.pem"
I1222 21:33:45.694308       8 ssl.go:531] "loading tls certificate" path="/usr/local/certificates/cert" key="/usr/local/certificates/key"
I1222 21:33:45.704105       8 nginx.go:255] "Starting NGINX Ingress controller"
I1222 21:33:45.709633       8 event.go:282] Event(v1.ObjectReference{Kind:"ConfigMap", Namespace:"ingress-nginx", Name:"ingress-nginx-controller", UID:"17e5d824-43ae-4e30-bd03-5ddc6c219c1a", APIVersion:"v1", ResourceVersion:"1451543", FieldPath:""}): type: 'Normal' reason: 'CREATE' ConfigMap ingress-nginx/ingress-nginx-controller
I1222 21:33:46.904447       8 nginx.go:297] "Starting NGINX process"
I1222 21:33:46.904532       8 leaderelection.go:248] attempting to acquire leader lease ingress-nginx/ingress-controller-leader...
I1222 21:33:46.904719       8 nginx.go:317] "Starting validation webhook" address=":8443" certPath="/usr/local/certificates/cert" keyPath="/usr/local/certificates/key"
I1222 21:33:46.904784       8 controller.go:155] "Configuration changes detected, backend reload required"
I1222 21:33:46.922016       8 leaderelection.go:258] successfully acquired lease ingress-nginx/ingress-controller-leader
I1222 21:33:46.922094       8 status.go:84] "New leader elected" identity="ingress-nginx-controller-54bfb9bb-shr4w"
I1222 21:33:46.954803       8 controller.go:172] "Backend successfully reloaded"
I1222 21:33:46.954859       8 controller.go:183] "Initial sync, sleeping for 1 second"
I1222 21:33:46.954896       8 event.go:282] Event(v1.ObjectReference{Kind:"Pod", Namespace:"ingress-nginx", Name:"ingress-nginx-controller-54bfb9bb-shr4w", UID:"3e815e08-5762-4205-af8e-57216a5ad719", APIVersion:"v1", ResourceVersion:"1451707", FieldPath:""}): type: 'Normal' reason: 'RELOAD' NGINX reload triggered due to a change in configuration

```

ingress service
---------------------

```bash
kubectl apply -f k8s-ingress-service.yaml --namespace ingress-nginx
service/ingress-nginx created

kubectl get pods --namespace ingress-nginx
NAME                                        READY     STATUS    RESTARTS   AGE
nginx-ingress-controller-65fd579494-6jcdx   1/1       Running   0          3m24s

λ kubectl get services --namespace ingress-nginx
NAME            TYPE           CLUSTER-IP       EXTERNAL-IP                                                              PORT(S)        AGE
ingress-nginx   LoadBalancer   a.b.c.d   abc.us-east-1.elb.amazonaws.com   80:30385/TCP   103s

```

ingress rules
---------------

```bash
λ kubectl apply -f k8s-ingress-rules.yaml --namespace test
Warning: extensions/v1beta1 Ingress is deprecated in v1.14+, unavailable in v1.22+; use networking.k8s.io/v1 Ingress
ingress.extensions/dev-ingress created

λ kubectl get ingress --namespace test
NAME          HOSTS          ADDRESS                                                                  PORTS     AGE
dev-ingress   dev.abc.info   abc.us-east-1.elb.amazonaws.com   80        93s
```

ingress controller pods
------------

```bash
λ kubectl describe ingress --namespace test
Name:             dev-ingress
Namespace:        test
Address:          abc.us-east-1.elb.amazonaws.com
Default backend:  default-http-backend:80 (<none>)
Rules:
  Host  Path  Backends
  ----  ----  --------
  *     
        /svc1(/|$)(.*)   rest-server:80 (<none>)
Annotations:
  kubectl.kubernetes.io/last-applied-configuration:  {"apiVersion":"extensions/v1beta1","kind":"Ingress","metadata":{"annotations":{"nginx.ingress.kubernetes.io/rewrite-target":"/$2","nginx.ingress.kubernetes.io/ssl-redirect":"false"},"name":"dev-ingress","namespace":"test"},"spec":{"rules":[{"http":{"paths":[{"backend":{"serviceName":"rest-server","servicePort":80},"path":"/svc1(/|$)(.*)"}]}}]}}

  nginx.ingress.kubernetes.io/rewrite-target:  /$2
  nginx.ingress.kubernetes.io/ssl-redirect:    false
Events:
  Type    Reason  Age               From                      Message
  ----    ------  ----              ----                      -------
  Normal  UPDATE  2m (x6 over 16h)  nginx-ingress-controller  Ingress test/dev-ingress

```


```bash
kubectl logs -f nginx-ingress-controller-65fd579494-6jcdx --namespace ingress-nginx
I0902 04:49:17.931741       8 status.go:309] updating Ingress test/dev-ingress status from [] to [{ abc.us-east-1.elb.amazonaws.com}]
I0902 04:49:17.936585       8 event.go:258] Event(v1.ObjectReference{Kind:"Ingress", Namespace:"test", Name:"dev-ingress", UID:"e2650132-cd3c-11e9-a9ee-0e52ab4772a4", APIVersion:"extensions/v1beta1", ResourceVersion:"6154763", FieldPath:""}): type: 'Normal' reason: 'UPDATE' Ingress test/dev-ingress
30.0.20.221 - [30.0.20.221] - - [02/Sep/2019:04:49:22 +0000] "PROXY TCP4 30.0.20.59 30.0.20.59 48168 30385" 400 163 "-" "-" 0 0.000 [] [] - - - - 96c0c05e5bb7437a16787861ce7cc9ea
30.0.1.254 - [30.0.1.254] - - [02/Sep/2019:04:49:24 +0000] "PROXY TCP4 30.0.1.187 30.0.1.187 22798 30385" 400 163 "-" "-" 0 0.000 [] [] - - - - f56ea4aafa02391ec14ac8ae64c65ebb
```


Delete resources
---

```bash
kubectl delete ingress my-ingress --namespace test
kubectl delete service  dev-nginx --namespace ingress-nginx
kubectl delete clusterrole nginx-ingress-clusterrole
kubectl delete clusterrolebinding nginx-ingress-clusterrole-nisa-binding

kubectl delete job ingress-nginx-admission-create --namespace=ingress-nginx
kubectl delete job ingress-nginx-admission-patch --namespace=ingress-nginx
```
