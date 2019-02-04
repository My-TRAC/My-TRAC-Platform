#!/bin/bash


CURRENT_PATH=`pwd`

cd ../../CIGO-Core/deployments/kubernetes/
./stop.sh

cd $CURRENT_PATH

#STARTS EXAMPLE_1: RATING_MODELER
cd ../../examples/RatingModeler/deployments/kubernetes/
./stop.sh

if [[ "$OSTYPE" == *"darwin"* ]]
then
  docker-machine rm cigo
fi

docker network rm cigo-compose_default
