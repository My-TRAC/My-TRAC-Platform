#!/bin/bash

if [[ "$OSTYPE" == *"darwin"* ]]
then
eval $(docker-machine env cigo)
fi

docker run -it --net=cigo-compose_default --rm sparsitytechnologies/cigo-schema-registry kafka-avro-console-producer -broker-list kafka:29092 --topic ratings  --property schema.registry.url="http://schema-registry:8081" --property value.schema='{"type":"record","name":"ratings_schema","fields":[{"name":"user_id","type":"int"},{"name":"activity_id", "type": "int"}, {"name":"rating", "type": "double"}]}'



#Example of messages:
#{"user_id":1,"activity_id":33,"rating":2.4}
