#/bin/bash

#delete initializing job containers
kubectl delete -f cigo-init.yaml

#Deletes Kibana
kubectl delete -f cigo-kibana-deployment.yaml 

#Deletes ElasticSearch
kubectl delete -f cigo-elasticsearch-deployment.yaml 

##Deletes Kafka Connect 
kubectl delete -f cigo-kafka-connect-deployment.yaml

##Deletes Schema Registry 
kubectl delete -f cigo-schema-registry-deployment.yaml

#Deletes Kafka
kubectl delete -f cigo-kafka-deployment.yaml

#Deletes Zookeeper
kubectl delete -f cigo-zookeeper-deployment.yaml 

kubectl get all
