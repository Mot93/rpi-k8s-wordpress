#! /bin/bash

# Deleting wordpress server resources
sudo kubectl -n wordpress delete ingress wordpress
sudo kubectl -n wordpress delete service wordpress
sudo kubectl -n wordpress delete deploy wordpress
sudo kubectl -n wordpress delete pvc wordpress-data
sudo kubectl delete pv wordpress-data

# Deleting db resources
sudo kubectl -n wordpress delete service db
sudo kubectl -n wordpress delete deploy db
sudo kubectl -n wordpress delete pvc db-data
sudo kubectl delete pv db-data

# Deleting namespace and secret
sudo kubectl -n wordpress delete secret db-secret
sudo kubectl delete namespace wordpress

# Deleting the persistent data
sudo rm -rf /mnt/data/db-data
sudo rm -rf /mnt/data/wordpress-data
