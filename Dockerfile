FROM centos

COPY nginx.repo /etc/yum.repos.d/nginx.repo
RUN yum -y install net-tools
RUN yum -y install nginx

COPY etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY etc/nginx/nginx_metrics.conf /etc/nginx/conf.d/status.conf

COPY index.html /usr/share/nginx/html

EXPOSE 8080 9090

CMD ["nginx", "-g", "daemon off;"]
