#!/bin/bash

eval $(docker-machine env cigo)
export CONNECT_HOST=`docker-machine ip cigo`

echo ""
echo "Deleting $1 connector to http://$CONNECT_HOST:28083/connectors"

echo ""
echo ""

curl -X DELETE  http://$CONNECT_HOST:28083/connectors/$1
echo ""
echo ""
