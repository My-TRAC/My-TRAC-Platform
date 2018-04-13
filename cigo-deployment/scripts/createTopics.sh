#!/bin/bash

docker run --net=host --rm confluentinc/cp-kafka:4.0.0 kafka-topics --create --topic cigo-offsets --partitions 1 --replication-factor 1 --if-not-exists --zookeeper localhost:32181
docker run --net=host --rm confluentinc/cp-kafka:4.0.0 kafka-topics --create --topic cigo-config --partitions 1 --replication-factor 1 --if-not-exists --zookeeper localhost:32181
docker run --net=host --rm confluentinc/cp-kafka:4.0.0 kafka-topics --create --topic cigo-status --partitions 1 --replication-factor 1 --if-not-exists --zookeeper localhost:32181
docker run --net=host --rm confluentinc/cp-kafka:4.0.0 kafka-topics --describe --zookeeper localhost:32181

# docker run --net=host --rm cigo/kafka kafka-topics --create --topic cigo-offsets --partitions 1 --replication-factor 1 --if-not-exists --zookeeper localhost:32181
# docker run --net=host --rm cigo/kafka kafka-topics --create --topic cigo-config --partitions 1 --replication-factor 1 --if-not-exists --zookeeper localhost:32181
# docker run --net=host --rm cigo/kafka kafka-topics --create --topic cigo-status --partitions 1 --replication-factor 1 --if-not-exists --zookeeper localhost:32181
# docker run --net=host --rm cigo/kafka kafka-topics --describe --zookeeper localhost:32181
