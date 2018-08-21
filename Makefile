.PHONY: build clean build-app-v1 build-app-v2 rm-images start-registry stop-registry start-minikube, check-dns

build: start-registry build-app-v1

clean: stop-registry rm-images

build-app-v1: start-registry
	cd docker; docker build --file ./Dockerfile.v1 --tag localhost:5000/my_app:v1 .
	docker push localhost:5000/my_app:v1

build-app-v2: start-registry
	cd docker; docker build --file ./Dockerfile.v2 --tag localhost:5000/my_app:v2 .
	docker push localhost:5000/my_app:v2

rm-images:
	[ -z $$(docker images --quiet registry:2) ] || docker rmi registry:2
	for img in $$(docker images 'localhost:5000/my_app' --format '{{ .ID }}'); do docker rmi $$img; done

start-registry:
	[ ! -z $$(docker ps --quiet --filter name=registry) ] || docker run -d -p 5000:5000 --name registry registry:2

stop-registry:
	[ -z $$(docker ps --quiet --filter name=registry) ] || (docker container stop registry && docker container rm -v registry)

start-minikube: CIDR=192.168.99.0/24
start-minikube:
	minikube start --insecure-registry "$(CIDR)"

run-container-in-cluster:
	kubectl run -it --image 'busybox:1.28.4' dns-test --restart=Never --rm --command -- /bin/sh
