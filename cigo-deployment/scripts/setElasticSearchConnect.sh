#!/bin/bash

export CONNECT_HOST=`docker-machine ip cigo`

# curl -X POST -H "Content-Type: application/json" --data '{ "name": "test-connector", "config": { "connector.class": "io.confluent.connect.elasticsearch.ElasticsearchSinkConnector", "tasks.max": "1", "topics": "test-topic", "key.ignore": "true", "schema.ignore": "true", "connection.url": "http://elasticsearch:9200", "type.name": "test-type", "name": "elasticsearch-sink" } }' http://$CONNECT_HOST:28083/connectors
curl -X POST -H "Content-Type: application/json" --data '{ "name": "test-connector", "config": { "connector.class": "io.confluent.connect.elasticsearch.ElasticsearchSinkConnector", "tasks.max": "1", "topics": "test-topic", "key.ignore": "true", "schema.ignore": "true", "connection.url": "http://$CONNECT_HOST:9200", "type.name": "test-type", "name": "elasticsearch-sink" } }' http://$CONNECT_HOST:28083/connectors
