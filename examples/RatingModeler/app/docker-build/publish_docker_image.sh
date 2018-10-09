#!/bin/bash

CURRENT_PATH=`pwd`

cd ..
mvn assembly:assembly

cd $CURRENT_PATH

cp ../target/RatingModeler-1.0-SNAPSHOT-jar-with-dependencies.jar .
docker build -t sparsitytechnologies/ratingmodeler:latest .
docker push sparsitytechnologies/ratingmodeler:latest
rm RatingModeler-1.0-SNAPSHOT-jar-with-dependencies.jar

