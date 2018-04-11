#!/bin/bash

kubectl exec cigo-kafka-0 -- kafka-topics --create --topic quickstart-avro-offsets --partitions 3 --replication-factor 3 --if-not-exists --zookeeper cigo-zookeeper-svc:32181
kubectl exec cigo-kafka-0 -- kafka-topics --create --topic quickstart-avro-config --partitions 3 --replication-factor 3 --if-not-exists --zookeeper cigo-zookeeper-svc:32181
kubectl exec cigo-kafka-0 -- kafka-topics --create --topic quickstart-avro-status --partitions 3 --replication-factor 3 --if-not-exists --zookeeper cigo-zookeeper-svc:32181

kubectl exec cigo-kafka-2 -- kafka-topics --describe --zookeeper cigo-zookeeper-svc:32181
