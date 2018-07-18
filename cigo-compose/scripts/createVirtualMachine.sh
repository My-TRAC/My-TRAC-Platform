#!/bin/bash

docker-machine create --driver virtualbox --virtualbox-memory 12000 cigo

eval $(docker-machine env cigo)

docker-machine ssh cigo -- "sudo sysctl -w vm.max_map_count=262144"

export CONNECT_HOST=`docker-machine ip cigo`
