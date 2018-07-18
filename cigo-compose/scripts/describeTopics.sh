#!/bin/bash
eval $(docker-machine env cigo)
docker run --net=cigo-compose_default --rm sparsitytechnologies/cigo-kafka kafka-topics --describe --zookeeper zookeeper:32181
