#!/bin/bash



if [[ "$OSTYPE" == "darwin" ]]
then
eval $(docker-machine env cigo)                                                  
fi

docker run --net=cigo-compose_default --rm sparsitytechnologies/cigo-kafka kafka-topics --describe --zookeeper zookeeper:32181 |grep Configs
