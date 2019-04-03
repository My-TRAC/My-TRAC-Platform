#!/bin/bash

CURRENT_PATH=`pwd`

if [[ "$OSTYPE" == *"darwin"* ]]
then
  echo "Creating virtual machine...." 
  scripts/createVirtualMachine.sh

  eval $(docker-machine env cigo)
fi

# Staring cigo-compose_default network
docker network create cigo-compose_default

#STARTS CIGO!-CORE
echo "Starting Cigo-Core"
cd ../../CIGO-Core/deployments/docker-compose/
./start.sh


cd $CURRENT_PATH

#STARTS EXAMPLE_1: RATING_MODELER
echo "Starting Rating Modeler"
cd ../../examples/RatingModeler/deployments/docker-compose/
./start.sh

if [[ "$OSTYPE" == *"darwin"* ]]
then
  echo "Summary" 
  eval $(docker-machine env cigo)
fi

cd $CURRENT_PATH
#docker-compose up -d

