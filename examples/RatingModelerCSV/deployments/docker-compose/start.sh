#!/bin/bash

if [[ $OSTYPE == *"darwin"* ]]
then
    docker-machine create --driver virtualbox --virtualbox-memory 12000 handsOn
    eval $(docker-machine env handsOn) 
    docker network create handsOnNet
fi

docker-compose up -d
