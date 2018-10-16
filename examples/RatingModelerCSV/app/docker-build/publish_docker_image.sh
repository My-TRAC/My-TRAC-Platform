#!/bin/bash

CURRENT_PATH=`pwd`

if [[ $OSTYPE == *"darwin"* ]]
then
    docker-machine create --driver virtualbox --virtualbox-memory 12000 handsOn
    eval $(docker-machine env handsOn)
    docker network create handsOnNet
fi

cd ..
mvn assembly:assembly
cd $CURRENT_PATH

cp ../target/RatingModelerCSV-1.0-SNAPSHOT-jar-with-dependencies.jar .
cp  -r ../src/test/resources .

docker build -t ratingmodelercsv:latest .
#docker push sparsitytechnologies/ratingmodelerCSV:latest
rm RatingModelerCSV-1.0-SNAPSHOT-jar-with-dependencies.jar
rm -rf ../target
rm -rf resources

