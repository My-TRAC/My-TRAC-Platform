#!/bin/bash

docker-machine create --driver virtualbox --virtualbox-memory 12000 cigo

eval $(docker-machine env cigo)

#docker-machine ssh cigo -- "mkdir -p /tmp/quickstart/jars"
#docker-machine ssh cigo -- "curl -k -SL "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.39.tar.gz" | tar -xzf - -C /tmp/quickstart/jars --strip-components=1 mysql-connector-java-5.1.39/mysql-connector-java-5.1.39-bin.jar"
docker-machine ssh cigo -- "sudo sysctl -w vm.max_map_count=262144"

export CONNECT_HOST=`docker-machine ip cigo`
