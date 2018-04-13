#/bin/bash

kubectl apply -f mysql-deployment.yaml --validate=false
sleep 20

kubectl apply -f gtfsloader-deployment.yaml --validate=false
sleep 20

./setJDBCConnector.sh 
sleep 10
