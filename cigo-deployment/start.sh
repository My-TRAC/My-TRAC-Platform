#!/bin/bash
                  
echo "Creating virtual machine...." 
scripts/createVirtualMachine.sh

echo "Deploying cigo..."
eval $(docker-machine env cigo)
docker-compose up -d
sleep 120                
scripts/setJDBCConnector.sh



#echo "Starting WebService for GTFS processing" 
#scripts/runGTFS.sh


echo "Summary" 
docker-machine env cigo

