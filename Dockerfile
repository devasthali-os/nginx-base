FROM centos

COPY nginx.repo /etc/yum.repos.d/nginx.repo
RUN yum -y install net-tools
RUN yum -y install nginx

COPY . /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]
