#!/bin/bash


export URL=$(minikube service cigo-kafka-connect-svc --url)
  

echo ""
echo "Adding connector to $URL/connectors"

echo ""
echo ""

curl -X POST \
  -H "Content-Type: application/json" \
  --data '{ "name": "cigo-jdbc-source", "config": { "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector", "tasks.max": 1,"connection.url": "jdbc:mysql://mysql-svc.default.svc.cluster.local:3306/connect_test?user=root&password=confluent", "mode": "incrementing", "incrementing.column.name": "id", "timestamp.column.name": "modified", "topic.prefix": "cigo-jdbc-", "poll.interval.ms": 1000 } }' \
  $URL/connectors

  echo ""
  echo ""
