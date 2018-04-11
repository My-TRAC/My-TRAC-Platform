#/bin/bash


#Deploys Zookeeper
kubectl apply -f cigo-zookeeper-deployment.yaml --validate=false

#Deploys Kafka
kubectl apply -f cigo-kafka-deployment.yaml --validate=false

#Deploys SchemaRegistry 
kubectl apply -f cigo-schema-registry-deployment.yaml

kubectl get statefulsets
kubectl get deployments 
kubectl get services 
kubectl get pods
