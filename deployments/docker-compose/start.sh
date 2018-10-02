#!/bin/bash

CURRENT_PATH=`pwd`

if [[ "$OSTYPE" == "darwin" ]]
then
  echo "Creating virtual machine...." 
  scripts/createVirtualMachine.sh

  echo "Deploying cigo..."
  eval $(docker-machine env cigo)
fi

#STARTS CIGO!-CORE
#docker network create cigo-compose_default
echo "Starting Cigo-Core"
cd ../../CIGO-Core/deployments/docker-compose/
./start.sh


cd $CURRENT_PATH

#STARTS EXAMPLE_1: RATING_MODELER
echo "Starting Rating Modeler"
cd ../../examples/RatingModeler/deployments/docker-compose/
./start.sh

if [[ "$OSTYPE" == "darwin" ]]
then
  echo "Summary" 
  docker-machine env cigo
fi
