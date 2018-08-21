#!/bin/bash

cp ../app/target/RatingModeler-1.0-SNAPSHOT-jar-with-dependencies.jar .
docker build -t sparsitytechnologies/ratingmodeler:latest .
docker push sparsitytechnologies/ratingmodeler:latest

