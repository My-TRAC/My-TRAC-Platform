#!/bin/bash

docker run --net=host --rm confluentinc/cp-schema-registry:4.0.0 kafka-avro-console-consumer --bootstrap-server localhost:29092 --topic $1 --new-consumer --from-beginning 
