# Deploy CIGO
## Create the Virtual Environment
This step is mandatory for OSX users. Theoretically, it is not required for UNIX or Windows users but it has never been tested.

```
$> ./start.sh
```

## Check deployed dockers are correct

`$> docker ps`, should retorn something like:

```
CONTAINER ID        IMAGE                                              COMMAND                  CREATED             STATUS              PORTS                                          NAMES
74182775ca33        sparsitytechnologies/cigo-kafka-connect:latest     "/etc/confluent/dock…"   2 hours ago         Up 2 hours          8083/tcp, 9092/tcp, 0.0.0.0:28083->28083/tcp   kafka-connect-avor
7bdd270803e2        sparsitytechnologies/cigo-schema-registry:latest   "/etc/confluent/dock…"   2 hours ago         Up 2 hours          8081/tcp                                       schema-registry
8cbf8bf29b7a        sparsitytechnologies/cigo-kafka:latest             "/etc/confluent/dock…"   2 hours ago         Up 2 hours          9092/tcp                                       kafka
71d7aec4c5a8        sparsitytechnologies/cigo-zookeeper:latest         "/etc/confluent/dock…"   2 hours ago         Up 2 hours          2181/tcp, 2888/tcp, 3888/tcp                   zookeeper
```
Do not pay attention to the CONTAINER ID, it is generated randomly for each deploy.



# Stop CIGO!

`$> stop.sh`

