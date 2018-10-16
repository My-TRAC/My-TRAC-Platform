#!/bin/bash

CURRENT_PATH=`pwd`

cd ..
mvn assembly:assembly

cd $CURRENT_PATH

if [[ $OSTYPE == *"darwin"* ]]
then
    docker-machine create --driver virtualbox --virtualbox-memory 12000 handsOn
    eval $(docker-machine env handsOn)
    docker network create handsOnNet
fi
 
cp  -r ../src/test/resources .
cp ../target/RatingModelerCSV-1.0-SNAPSHOT-jar-with-dependencies.jar .
docker build -t ratingmodelercsv:latest .
#docker push sparsitytechnologies/ratingmodelerCSV:latest
rm RatingModelerCSV-1.0-SNAPSHOT-jar-with-dependencies.jar
rm -rf ../target
rm -rf resources

