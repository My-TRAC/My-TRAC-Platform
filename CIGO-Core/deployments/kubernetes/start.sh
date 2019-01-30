#/bin/bash

echo "Deploying CIGO! Core..."

#Deploys Zookeeper
kubectl apply -f cigo-zookeeper-deployment.yaml
sleep 5

#Deploys Kafka
kubectl apply -f cigo-kafka-deployment.yaml
sleep 5

#Deploys SchemaRegistry 
kubectl apply -f cigo-schema-registry-deployment.yaml
sleep 5

#Deploys Kafka Connect
kubectl apply -f cigo-kafka-connect-deployment.yaml
sleep 5

#Deploys Elasticsearch
kubectl apply -f cigo-elasticsearch-deployment.yaml
sleep 5

#Deploys Kibana
kubectl apply -f cigo-kibana-deployment.yaml
sleep 5

#Run init script
kubectl apply -f cigo-init.yaml

kubectl get all
