FROM centos

COPY nginx.repo /etc/yum.repos.d/nginx.repo
RUN yum -y install net-tools
RUN yum -y install nginx

COPY /etc/config/nginx.conf /etc/nginx/nginx.conf
COPY /etc/config/nginx_metrics.conf /etc/nginx/conf.d/status.conf

COPY . /usr/share/nginx/html

EXPOSE 9090

CMD ["nginx", "-g", "daemon off;"]
