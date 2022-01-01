# rpi-k8s-wordpress
Not all containers are avaliable for the ARM process acrchitecture,

This project contains everything needed to run wordpress and it's database on kubernetes both on `x86` and `ARMv8`

# docker-compose.yaml
This `docker-compose` contains the description of all the component needed to setup the wordpress.

## How to use docker-compose
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
