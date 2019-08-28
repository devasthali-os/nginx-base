FROM centos

COPY nginx.repo /etc/yum.repos.d/nginx.repo
RUN yum -y install net-tools
RUN yum -y install nginx

COPY nginx.conf /etc/nginx/nginx.conf
COPY . /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]
