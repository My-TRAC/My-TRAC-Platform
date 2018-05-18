#!/bin/bash


export URL="$KAFKA_CONNECT_HOST:28083"
export MYSQL="$MYSQL_HOST"

echo ""
echo "Adding connector to $URL/connectors"

echo ""
echo ""

curl -X DELETE $URL/connectors/cigo-jdbc-source

echo ""
echo ""
