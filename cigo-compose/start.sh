#!/bin/bash
                  
echo "Creating virtual machine...." 
scripts/createVirtualMachine.sh

echo "Deploying cigo..."
eval $(docker-machine env cigo)
docker-compose up -d
#sleep 120                
#scripts/setJDBCConnector.sh



#echo "Starting WebService for GTFS processing" 
#scripts/runGTFS.sh

# Initializing cigo
echo "Initializing CIGO"
docker run -e DATA_MODEL_REPOSITORY=https://github.com/My-TRAC/data-model \
  -e SCHEMA_REGISTRY_HOST_NAME=schema-registry:8081 \
  --network cigo-compose_default \
  sparsitytechnologies/cigo-init

echo "Summary" 
docker-machine env cigo

