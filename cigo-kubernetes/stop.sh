#/bin/bash

#Deploys Zookeeper
kubectl delete -f cigo-zookeeper-deployment.yaml 

#Deploys Kafka
kubectl delete -f cigo-kafka-deployment.yaml

##Deploys SchemaRegistry 
kubectl delete -f cigo-schema-registry-deployment.yaml

kubectl get statefulsets
kubectl get deployments 
kubectl get services 
kubectl get pods

