#!/bin/bash

if [[ "$OSTYPE" == *"darwin"* ]]
then
eval $(docker-machine env cigo)                                                  
fi

docker run --net=cigo-compose_default --rm sparsitytechnologies/cigo-schema-registry kafka-avro-console-consumer --bootstrap-server kafka:29092 --topic $1 --new-consumer --from-beginning --property schema.registry.url="http://schema-registry:8081"  --property print.key=true
