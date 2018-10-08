#!/bin/bash

if [[ "$OSTYPE" == *"darwin"* ]]
then
  eval $(docker-machine env cigo)
  export CONNECT_HOST=`docker-machine ip cigo`
else
  export CONNECT_HOST="localhost"
fi

docker-compose stop

