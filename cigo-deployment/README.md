# Deploy CIGO
## Create the Virtual Environment
This step is mandatory for OSX users. Theoretically, it is not required for UNIX or Windows users but it has never been tested.

```
$> ./start.sh
```

## Check deployed dockers are correct

`$> docker ps`, should retorn something like:

```
CONTAINER ID        IMAGE                                                 COMMAND                  CREATED             STATUS              PORTS               NAMES
b188d212ce84        confluentinc/cp-kafka-connect:latest                  "/etc/confluent/dock…"   7 minutes ago       Up 7 minutes                            kafka-connect-avor
9d5defd049fb        confluentinc/cp-schema-registry:4.0.0                 "/etc/confluent/dock…"   7 minutes ago       Up 7 minutes                            schema-registry
a6a8d90ecaeb        mysql                                                 "docker-entrypoint.s…"   7 minutes ago       Up 7 minutes                            mysql
66a367140ca2        docker.elastic.co/elasticsearch/elasticsearch:5.6.3   "/bin/bash bin/es-do…"   7 minutes ago       Up 7 minutes                            elasticsearch
d3f86eeccf0b        confluentinc/cp-zookeeper:4.0.0                       "/etc/confluent/dock…"   7 minutes ago       Up 7 minutes                            zookeeper
0aa5f92d703a        confluentinc/cp-kafka:4.0.0                           "/etc/confluent/dock…"   7 minutes ago       Up 7 minutes                            kafka
```
Do not pay attention to the CONTAINER ID, it is generated randomly for each deploy.



#Stop CIGO!

``` 
$> stop.sh
```

