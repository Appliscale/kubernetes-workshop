.PHONY: all build-app-v1 build-app-v2 start-registry stop-registry

all:

build-app-v1:
	cd docker; docker build --file ./Dockerfile.v1 --tag localhost:5000/my_app .
	docker push localhost:5000/my_app

build-app-v2:
	cd docker; docker build --file ./Dockerfile.v2 --tag localhost:5000/my_app .
	docker push localhost:5000/my_app

start-registry:
	docker run -d -p 5000:5000 --name registry registry:2

stop-registry:
	docker container stop registry && docker container rm -v registry
