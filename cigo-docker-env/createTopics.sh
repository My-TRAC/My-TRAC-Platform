#!/bin/bash

docker run --net=host --rm confluentinc/cp-kafka:4.0.0 kafka-topics --create --topic quickstart-avro-offsets --partitions 1 --replication-factor 1 --if-not-exists --zookeeper localhost:32181
docker run --net=host --rm confluentinc/cp-kafka:4.0.0 kafka-topics --create --topic quickstart-avro-config --partitions 1 --replication-factor 1 --if-not-exists --zookeeper localhost:32181
docker run --net=host --rm confluentinc/cp-kafka:4.0.0 kafka-topics --create --topic quickstart-avro-status --partitions 1 --replication-factor 1 --if-not-exists --zookeeper localhost:32181
docker run --net=host --rm confluentinc/cp-kafka:4.0.0 kafka-topics --describe --zookeeper localhost:32181

# docker run --net=host --rm cigo/kafka kafka-topics --create --topic quickstart-avro-offsets --partitions 1 --replication-factor 1 --if-not-exists --zookeeper localhost:32181
# docker run --net=host --rm cigo/kafka kafka-topics --create --topic quickstart-avro-config --partitions 1 --replication-factor 1 --if-not-exists --zookeeper localhost:32181
# docker run --net=host --rm cigo/kafka kafka-topics --create --topic quickstart-avro-status --partitions 1 --replication-factor 1 --if-not-exists --zookeeper localhost:32181
# docker run --net=host --rm cigo/kafka kafka-topics --describe --zookeeper localhost:32181
