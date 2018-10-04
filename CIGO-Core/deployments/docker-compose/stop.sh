#!/bin/bash

if [[ "$OSTYPE" == *"darwin"* ]]
then
  eval $(docker-machine env cigo)
  export CONNECT_HOST=`docker-machine ip cigo`
else
  export CONNECT_HOST="localhost"
fi

curl -X DELETE $CONNECT_HOST:28083/connectors/cigo-jdbc-source

docker-compose stop

