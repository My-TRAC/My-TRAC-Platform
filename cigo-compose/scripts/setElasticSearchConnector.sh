
#!/bin/bash

eval $(docker-machine env cigo)
export CONNECT_HOST=`docker-machine ip cigo`
  
echo ""
echo "Adding Elastic-Search connector to http://$CONNECT_HOST:28083/connectors"

echo ""
echo ""



# curl -X POST   -H "Content-Type: application/json" --data '{"name": "elasticsearch-connector", "config": { "connector.class": "io.confluent.connect.elasticsearch.ElasticsearchSinkConnector", "tasks.max": "1", "topics": "test-topic", "key.ignore": "true", "schema.ignore": "true", "connection.url": "http://elasticsearch:9200", "type.name": "test-type", "name": "elasticsearch-sink" }}' http://$CONNECT_HOST:28083/connectors

curl -X POST   -H "Content-Type: application/json" --data '{"name": "elasticsearch-connector", "config": { "connector.class": "io.confluent.connect.elasticsearch.ElasticsearchSinkConnector", "tasks.max": "1", "key.ignore": "true", "schema.ignore": "true", "connection.url": "http://elasticsearch:9200", "type.name": "test-type", "name": "elasticsearch-sink" }}' http://$CONNECT_HOST:28083/connectors

  echo ""
echo ""
