#/bin/bash

##Deletes Kafka Connect 
kubectl delete -f cigo-kafka-connect-deployment.yaml


##Deletes Schema Registry 
kubectl delete -f cigo-schema-registry-deployment.yaml

#Deletes Kafka
kubectl delete -f cigo-kafka-deployment.yaml

#Deletes Zookeeper
kubectl delete -f cigo-zookeeper-deployment.yaml 

kubectl get statefulsets
kubectl get deployments 
kubectl get services 
kubectl get pods

