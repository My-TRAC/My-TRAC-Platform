# Deploy CIGO
## Create the Virtual Environment
This step is mandatory for OSX users. Theoretically, it is not required for UNIX or Windows users but it has never been tested.

```
$> ./createVirtualMachine.sh
$> eval $(docker-machine env cigo)
$> export CONNECT_HOST=`docker-machine ip cigo`
```

## Deploy the required dockers

```
$> docker-compose up -d
```
If everything went well the command 
`$> docker ps`, should retorn something like:

```
CONTAINER ID        IMAGE                                                 COMMAND                  CREATED             STATUS              PORTS               NAMES
b188d212ce84        confluentinc/cp-kafka-connect:latest                  "/etc/confluent/dock…"   7 minutes ago       Up 7 minutes                            kafka-connect-avor
9d5defd049fb        confluentinc/cp-schema-registry:4.0.0                 "/etc/confluent/dock…"   7 minutes ago       Up 7 minutes                            schema-registry
a6a8d90ecaeb        mysql                                                 "docker-entrypoint.s…"   7 minutes ago       Up 7 minutes                            quickstart-mysql
66a367140ca2        docker.elastic.co/elasticsearch/elasticsearch:5.6.3   "/bin/bash bin/es-do…"   7 minutes ago       Up 7 minutes                            elasticsearch
d3f86eeccf0b        confluentinc/cp-zookeeper:4.0.0                       "/etc/confluent/dock…"   7 minutes ago       Up 7 minutes                            zookeeper
0aa5f92d703a        confluentinc/cp-kafka:4.0.0                           "/etc/confluent/dock…"   7 minutes ago       Up 7 minutes                            kafka
```
Do not pay attention to the CONTAINER ID, it is generated randomly for each deploy.

## Start required kafka topics

```
$> ./createTopics.sh
```

## Set the JDBC Connector

```
$> ./setJDBCConnector.sh
```
If everything is fine this message should appear: 

```
{"name":"quickstart-jdbc-source","config":{"connector.class":"io.confluent.connect.jdbc.JdbcSourceConnector","tasks.max":"1","connection.url":"jdbc:mysql://127.0.0.1:3306/connect_test?user=root&password=confluent","mode":"incrementing","incrementing.column.name":"id","timestamp.column.name":"modified","topic.prefix":"quickstart-jdbc-","poll.interval.ms":"1000","name":"quickstart-jdbc-source"},"tasks":[],"type":null}
```

