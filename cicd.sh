docker build -t nginx-base:1.0.0 .
docker run -it -p 9090:80 nginx-base:1.0.0 
