#/bin/bash

#Deletes SchemaRegistry 
kubectl delete deployments/cigo-schema-registry
kubectl delete services/cigo-schema-registry-svc

#Deletes Kafka
kubectl delete statefulsets/cigo-kafka
kubectl delete services/cigo-kafka-svc

#Deletes Zookeeper
kubectl delete statefulsets/cigo-zookeeper
kubectl delete services/cigo-zookeeper-svc

kubectl get statefulsets
kubectl get deployments 
kubectl get services 
kubectl get pods

