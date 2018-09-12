#!/bin/bash

echo "Waiting for Schema-registry"

export URL="$SCHEMA_REGISTRY_HOST_NAME:8081"
export schema='{"schema":"{\"type\":\"record\",\"name\":\"ratings_schema\",\"fields\":[{\"name\":\"user_id\",\"type\":\"int\"},{\"name\":\"activity_id\",\"type\":\"int\"},{\"name\":\"rating\",\"type\":\"double\"}]}"}'




until 
curl -X POST -H "Content-Type: application/json" --data '{"schema":"{\"type\":\"record\",\"name\":\"ratings_schema\",\"fields\":[{\"name\":\"user_id\",\"type\":\"int\"},{\"name\":\"activity_id\",\"type\":\"int\"},{\"name\":\"rating\",\"type\":\"double\"}]}"}' http://schema-registry:8081/subjects/ratings-value/versions
  do
    sleep 5
	echo "...schema registry still loading..."
done






