#!/bin/bash

git clone https://github.com/My-TRAC/ConfigurationScripts.git

chmod +x ./ConfigurationScripts/*.sh


/opt/RatingModeler/ConfigurationScripts/waitForSchemaRegistry.sh
/opt/RatingModeler/ConfigurationScripts/waitForKafkaConenct.sh
/opt/RatingModeler/ConfigurationScripts/waitForMySQL.sh
# /opt/RatingModeler/ConfigurationScripts/setJDBCSinkConnector.sh cigo-jdbc-sink_RatingModeler

/opt/RatingModeler/ConfigurationScripts/setJDBCSinkConnector.sh  -c "cigo-jdbc-sink_RatingModeler"\
                                                                 -k $KAFKA_CONNECT_HOST\
                                                                 -s $SCHEMA_REGISTRY_HOST_NAME\
                                                                 -n $SINK_TOPICS\
                                                                 -m $MYSQL_HOST\
                                                                 -d $MYSQL_DATABASE\
                                                                 -u $MYSQL_USER\
                                                                 -p $MYSQL_PASSWORD\
                                                                 -pk "mytrac_id"\
                                                                 -ac "true"


/opt/RatingModeler/ConfigurationScripts/setJDBCSourceConnector.sh -c "cigo-jdbc-source_RatingModeler"\
                                                -k $KAFKA_CONNECT_HOST\
                                                -m $MYSQL_HOST\
                                                -d $MYSQL_DATABASE\
                                                -u $MYSQL_USER\
                                                -p $MYSQL_PASSWORD\
                                                -i "mytrac_id"\
                                                -t "mytrac_last_modified"\
                                                -f "CigoJdbc"\
                                                -n "ActivitiesSummary"



#/opt/RatingModeler/ConfigurationScripts/setJDBCConnector.sh      CigoJdbc ratings
#/opt/RatingModeler/ConfigurationScripts/setElasticSearchConnector.sh
java -jar /opt/RatingModeler/RatingModeler-1.0-SNAPSHOT-jar-with-dependencies.jar -db connect_test -ip $MYSQL_HOST 
