#!/bin/bash


export URL=$(minikube service cigo-kafka-connect-svc --url)
  

echo ""
echo "Adding connector to $URL/connectors"

echo ""
echo ""

curl -X POST $URL/connectors/cigo-jdbc-source/restart

echo ""
echo ""
