#!/bin/bash

docker run --net=cigo-compose_default --rm sparsitytechnologies/cigo-schema-registry kafka-avro-console-consumer --bootstrap-server kafka:29092 --topic $1 --new-consumer --from-beginning 
