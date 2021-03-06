#!/bin/bash

eval $(docker-machine env cigo)
export CONNECT_HOST=`docker-machine ip cigo`
  
echo ""
echo "Adding JDBC connector to http://$CONNECT_HOST:28083/connectors"

echo ""
echo ""


curl -X POST \
  -H "Content-Type: application/json" \
  --data '{ "name": "cigo-jdbc-source", "config": { "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector", "tasks.max": 1, "connection.url": "jdbc:mysql://mysql:3306/connect_test?user=confluent&password=confluent", "mode": "incrementing", "incrementing.column.name": "id", "timestamp.column.name": "modified", "topic.prefix": "cigo-jdbc-", "poll.interval.ms": 1000, "key.converter":"io.confluent.connect.avro.AvroConverter", "key.converter.schema.registry.url": "http://schema-registry:8081","value.converter": "io.confluent.connect.avro.AvroConverter", "value.converter.schema.registry.url": "http://schema-registry:8081"} }' \
  http://$CONNECT_HOST:28083/connectors


#curl -X POST \
#  -H "Content-Type: application/json" \
#  --data '{ "name": "cigo-jdbc-source", "config": { "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector", "tasks.max": 1, "connection.url": "jdbc:mysql://mysql:3306/connect_test?user=confluent&password=confluent", "mode": "incrementing", "incrementing.column.name": "id", "timestamp.column.name": "modified", "topic.prefix": "cigo-jdbc-", "poll.interval.ms": 1000 } }' \
#  http://$CONNECT_HOST:28083/connectors
  



  echo ""
  echo ""
