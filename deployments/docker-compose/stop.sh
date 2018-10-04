#!/bin/bash


CURRENT_PATH=`pwd`

cd ../../CIGO-Core/deployments/docker-compose/
./stop.sh

cd $CURRENT_PATH

#STARTS EXAMPLE_1: RATING_MODELER
cd ../../examples/RatingModeler/deployments/docker-compose/
./stop.sh

if [[ "$OSTYPE" == *"darwin"* ]]
then
  docker-machine rm cigo
fi

docker network rm cigo-compose_default
