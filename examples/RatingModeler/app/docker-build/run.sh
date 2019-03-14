#!/bin/bash

git clone https://github.com/My-TRAC/ConfigurationScripts.git

chmod +x ./ConfigurationScripts/*.sh


/opt/RatingModeler/ConfigurationScripts/waitForSchemaRegistry.sh
/opt/RatingModeler/ConfigurationScripts/waitForKafkaConenct.sh
/opt/RatingModeler/ConfigurationScripts/waitForMySQL.sh
/opt/RatingModeler/ConfigurationScripts/setJDBCSinkConnector.sh cigo-jdbc-sink_RatingModeler
/opt/RatingModeler/ConfigurationScripts/setJDBCConnector.sh     cigo-jdbc-source_RatingModeler CigoJdbc ratings
#/opt/RatingModeler/ConfigurationScripts/setElasticSearchConnector.sh
java -jar /opt/RatingModeler/RatingModeler-1.0-SNAPSHOT-jar-with-dependencies.jar -db connect_test -ip $MYSQL_HOST 
