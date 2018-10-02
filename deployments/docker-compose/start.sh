#!/bin/bash

CURRENT_PATH=`pwd`





#STARTS CIGO!-CORE
#docker network create cigo-compose_default
cd ../../CIGO-Core/deployments/docker-compose/
./start.sh


cd $CURRENT_PATH


#STARTS EXAMPLE_1: RATING_MODELER
cd ../../examples/RatingModeler/deployments/docker-compose/
./start.sh

