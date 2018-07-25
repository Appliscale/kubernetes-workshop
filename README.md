## This repositroy contains materials for basic Kubernetes functionalities tutorial
To use files in repository, following requirements must be fulfilled:
1. [Docker](https://docs.docker.com/install/)
2. [Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)
3. [Helm](https://github.com/kubernetes/helm/blob/master/docs/install.md)

## To configure cluster:
1. `make start-minikube CIDR=<CIDR>`, host must be able to connect to minikube VM on this network! (Default "192.168.99.0/24")
2. `helm init`
3. `make build`

Take a look at `my-app/values.yaml`, make sure that IP is correct there (it should point to host).
In `Makefile` some targets are configured to ease maintenance.

`scripts` folder contains helper scripts:
```
  copy_file_to_pod
  port_forward
  scale_deployment
  set_docker_image
```
Each script is delivered with CLI usage help.

### To deploy application
`helm install ./my-app`

### Rollout application update
```
  make build-app-v2
  scripts/set_docker_image ...
```

### Undo rollout
```
  kubectl rollout undo deployment/... --to-revision=...
```

### Scale deployment
```
  scripts/scale_deployment ...
```

### Copy file to pod
```
  scripts/copy_file_to_pod ...
```

### Forward port from pod to host
```
  scripts/port_forward ...
```
