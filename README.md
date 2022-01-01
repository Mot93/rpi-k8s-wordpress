# rpi-k8s-wordpress
Not all containers are avaliable for the ARM process acrchitecture,

This project contains everything needed to run wordpress and it's database on kubernetes both on `x86` and `ARMv8`

# docker-compose.yaml
This `docker-compose` contains the description of all the component needed to setup the wordpress.

## How to use docker-compose with podman-compose
**NOTE**: podman-compose volumes are currently broken

1. Build all the necessary images

        podman-compose -p wp build

2. Build the infrastructure and start all the containers
    
    **NOTE**: Unlike with docker-compose, all container are inside the same pod and cannot listen on the same port.

        podman-compose -p wp up -d

3. Stop all the container and dismantle the infrastructure

        podman-compose -p wp down

## Using `docker-compose`
Just replace `podman-compose` with `docker-compose`.

**NOTE**: unlike `docker-compose` all container are place in a virtual network and can listen on the same port.

# Moving to K8s
Now that the `docker-compose` works as intended we can migrate to kubernetes.

## Using `podman-compose`
[podman-compose](https://github.com/containers/podman-compose) is a great projects that turn your [docker-compose.yaml](https://docs.docker.com/compose/compose-file/) into a pod ready to be used on k8s.

    podman-compose -p wp up -d --build 

Once you created a pod in podman, you can generate a kubernetes config file

    podman generate kube -s wp > podman-k8s/kube-jenkins.yaml

Rembember to take down the podman-compose pod

    podman-compose -p wp down


## Using `kompose`
[Kompose](https://github.com/kubernetes/kompose) is a great tool to turn your [docker-compose.yaml](https://docs.docker.com/compose/compose-file/) into a kubernetes configuration.

    kompose convert -o kompose/ 

## Testing the K8s config corectness
To test the generate config file, use [kubeval](https://www.kubeval.com).

***`podman-compose`***

    kubeval podman-k8s/kube-jenkins.yaml

***`kompose`***

    kubeval kompose/jenkins-deployment.yaml
    kubeval kompose/jenkins-service.yaml

# K8s testing
There are serveral way to test the kubernetes configurations

## K8s 
There are several project aimed to deploy lightweight k8s such as: [minikube](https://minikube.sigs.k8s.io/docs/), [minishif](https://www.okd.io/minishift/) or [k3s](https://k3s.io/).

To apply to k8s the configuration:

    kubectl apply -f <kubernetes config>

## `podman play`
Podman offers to run some of the kubernetes configurations via `podman play` tool:

    podman play kube <kubernetes config>