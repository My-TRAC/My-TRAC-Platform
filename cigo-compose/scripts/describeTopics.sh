#!/bin/bash

docker run --net=cigo-compose_default --rm sparsitytechnologies/cigo-kafka kafka-topics --describe --zookeeper zookeeper:32181
