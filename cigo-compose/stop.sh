#!/bin/bash

eval $(docker-machine env cigo)


export CONNECT_HOST=`docker-machine ip cigo`
curl -X DELETE $CONNECT_HOST:28083/connectors/cigo-jdbc-source



docker-compose stop
