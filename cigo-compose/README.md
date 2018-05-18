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
b188d212ce84        sparsitytechnologies/cigo-kafka-connect:latest                  "/etc/confluent/dock…"   7 minutes ago       Up 7 minutes                            kafka-connect-avor
9d5defd049fb        sparsitytechnologies/cigo-schema-registry:latest                 "/etc/confluent/dock…"   7 minutes ago       Up 7 minutes                            schema-registry
d3f86eeccf0b        sparsitytechnologies/cigo-zookeeper:latest                       "/etc/confluent/dock…"   7 minutes ago       Up 7 minutes                            zookeeper
0aa5f92d703a        sparsitytechnologies/cigo-kafka:latest                           "/etc/confluent/dock…"   7 minutes ago       Up 7 minutes                            kafka
```
Do not pay attention to the CONTAINER ID, it is generated randomly for each deploy.



# Stop CIGO!

`$> stop.sh`

