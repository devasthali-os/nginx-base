k8s ingress controller
-----------------------

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/mandatory.yaml
namespace/ingress-nginx created
configmap/nginx-configuration created
configmap/tcp-services created
configmap/udp-services created
serviceaccount/nginx-ingress-serviceaccount created
clusterrole.rbac.authorization.k8s.io/nginx-ingress-clusterrole created
role.rbac.authorization.k8s.io/nginx-ingress-role created
rolebinding.rbac.authorization.k8s.io/nginx-ingress-role-nisa-binding created
clusterrolebinding.rbac.authorization.k8s.io/nginx-ingress-clusterrole-nisa-binding created
deployment.apps/nginx-ingress-controller created

λ kubectl get pods -n ingress-nginx
NAME                                        READY     STATUS    RESTARTS   AGE
nginx-ingress-controller-65fd579494-6jcdx   1/1       Running   0          26s
```

```bash
kubectl apply -f k8s-ingress-controller.yaml --namespace ingress-nginx
service/ingress-nginx created

kubectl get pods --namespace ingress-nginx
NAME                                        READY     STATUS    RESTARTS   AGE
nginx-ingress-controller-65fd579494-6jcdx   1/1       Running   0          3m24s

λ kubectl get services --namespace ingress-nginx
NAME            TYPE           CLUSTER-IP       EXTERNAL-IP                                                              PORT(S)        AGE
ingress-nginx   LoadBalancer   a.b.c.d   abc.us-east-1.elb.amazonaws.com   80:30385/TCP   103s

```

```bash
λ kubectl apply -f k8s-ingress-rules.yaml --namespace test
ingress.extensions/dev-ingress created

λ kubectl get ingress --namespace test
NAME          HOSTS          ADDRESS                                                                  PORTS     AGE
dev-ingress   dev.abc.info   abc.us-east-1.elb.amazonaws.com   80        93s
```

ingress pod
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
