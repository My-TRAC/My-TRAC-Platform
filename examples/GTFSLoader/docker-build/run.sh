#!/bin/bash

setJDBCConnector.sh
java -jar /opt/GTFSLoader/GTFSLoader-1.0-SNAPSHOT-jar-with-dependencies.jar -db connect_test -ip $MYSQL_HOST 
