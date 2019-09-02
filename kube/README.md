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

