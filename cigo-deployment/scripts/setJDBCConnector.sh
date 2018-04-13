#!/bin/bash

eval $(docker-machine env cigo)
export CONNECT_HOST=`docker-machine ip cigo`
  
echo ""
echo "Adding connector to http://$CONNECT_HOST:28083/connectors"

echo ""
echo ""

curl -X POST \
  -H "Content-Type: application/json" \
  --data '{ "name": "cigo-jdbc-source", "config": { "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector", "tasks.max": 1, "connection.url": "jdbc:mysql://127.0.0.1:3306/connect_test?user=root&password=confluent", "mode": "incrementing", "incrementing.column.name": "id", "timestamp.column.name": "modified", "topic.prefix": "cigo-jdbc-", "poll.interval.ms": 1000 } }' \
  http://$CONNECT_HOST:28083/connectors

  echo ""
  echo ""
