#!/bin/bash

CURRENT_PATH=`pwd`

#STARTS CIGO!-CORE
echo "Starting Cigo-Core"
cd ../../CIGO-Core/deployments/kubernetes/
./start.sh

cd $CURRENT_PATH

#STARTS EXAMPLE_1: RATING_MODELER
echo "Starting Rating Modeler"
cd ../../examples/RatingModeler/deployments/kubernetes/
./start.sh

