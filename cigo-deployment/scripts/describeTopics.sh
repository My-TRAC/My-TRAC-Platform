#!/bin/bash

docker run --net=host --rm confluentinc/cp-kafka:4.0.0 kafka-topics --describe --zookeeper localhost:32181
