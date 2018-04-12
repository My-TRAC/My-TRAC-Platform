#/bin/bash


#Deploys Zookeeper
kubectl apply -f cigo-zookeeper-deployment.yaml --validate=false
sleep 30

#Deploys Kafka
kubectl apply -f cigo-kafka-deployment.yaml --validate=false
sleep 30

#Deploys SchemaRegistry 
kubectl apply -f cigo-schema-registry-deployment.yaml
sleep 10

kubectl get statefulsets
kubectl get deployments 
kubectl get services 
kubectl get pods
