#/bin/bash

echo "Deployin Rating Modeler..."

kubectl apply -f mysql-deployment.yaml 
sleep 60

kubectl apply -f ratingmodeler-deployment.yaml

