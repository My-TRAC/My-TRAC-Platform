#!/bin/bash

sleep 180
/opt/GTFSLoader/scripts/waitForKafkaConenct.sh
/opt/GTFSLoader/scripts/setJDBCConnector.sh
java -jar /opt/GTFSLoader/GTFSLoader-1.0-SNAPSHOT-jar-with-dependencies.jar -db connect_test -ip $MYSQL_HOST 
