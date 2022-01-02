#! /bin/bash

# Creating the namespace
sudo kubectl apply \
    -f namespace.yaml \
    -f db-secret.yaml

# Creating the resource for the database
sudo kubectl apply \
    -f db-data-persistentvolume.yaml \
    -f db-data-persistentvolumeclaim.yaml \
    -f db-deployment.yaml \
    -f db-service.yaml

# Creating the resources for the wordpress server
sudo kubectl apply \
    -f wordpress-data-persistentvolume.yaml \
    -f wordpress-data-persistentvolumeclaim.yaml \
    -f wordpress-deployment.yaml \
    -f wordpress-service.yaml \
    -f wordpress-ingress.yaml