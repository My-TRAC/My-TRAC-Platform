#!/bin/bash

/opt/RatingModeler/scripts/waitForSchemaRegistry.sh
/opt/RatingModeler/scripts/waitForKafkaConenct.sh
/opt/RatingModeler/scripts/waitForMySQL.sh
/opt/RatingModeler/scripts/setJDBCConnector.sh
/opt/RatingModeler/scripts/setJDBCSinkConnector.sh
#/opt/RatingModeler/scripts/setElasticSearchConnector.sh
java -jar /opt/RatingModeler/RatingModeler-1.0-SNAPSHOT-jar-with-dependencies.jar -db connect_test -ip $MYSQL_HOST 
