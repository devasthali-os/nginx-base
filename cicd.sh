# https://docs.aws.amazon.com/cli/latest/reference/ecr/create-repository.html
# aws ecr create-repository --repository-name nx
APPLICATION_VERSION=1.0.0
CONTAINER_REGISTRY=%%%.dkr.ecr.us-east-1.amazonaws.com

docker build -t nginx-base:${APPLICATION_VERSION} .

docker tag nginx-base:${APPLICATION_VERSION} ${CONTAINER_REGISTRY}/nx:${APPLICATION_VERSION}
$(aws ecr get-login --no-include-email)
docker push ${CONTAINER_REGISTRY}/nx:${APPLICATION_VERSION}

#docker run -it -p 9090:80 nginx-base:${APPLICATION_VERSION} 
