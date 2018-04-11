# CIGO on KUBERNETES
## Requirements
Kubernetes is a framework for managing the scaling of containerized applications on clusters. However, you do not need a cluster to deploy and test the CIGO platform. One can use [Minikube](https://kubernetes.io/docs/getting-started-guides/minikube/), which creates a virtual cluster locally to be used with Kubernetes. 

Besides Minikube, you also need to [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/), which is the commmand line tool to control a Kubernetes cluster (or Minikube) locally. 


## Deploy the CIGO platform on KUBERNETES

```
$> ./start.sh
```
If everything went,the command `kubectl get pods` should prdouce an output similar to the following

```
NAME                                    READY     STATUS    RESTARTS   AGE
cigo-kafka-0                            1/1       Running   0          16m
cigo-kafka-1                            1/1       Running   0          16m
cigo-kafka-2                            1/1       Running   0          16m
cigo-schema-registry-5464d44bbc-m822j   1/1       Running   0          16m
cigo-zookeeper-0                        1/1       Running   0          16m
cigo-zookeeper-1                        1/1       Running   0          16m
cigo-zookeeper-2                        1/1       Running   0          16m
```

## Create the required kafka topics

To initialize the required kafka topics, run the following command:

```
$> ./createTopics.sh
```
which should produce an output similar to:

```
Created topic "quickstart-avro-offsets".
Created topic "quickstart-avro-config".
Created topic "quickstart-avro-status".
Topic:quickstart-avro-config    PartitionCount:3        ReplicationFactor:3     Configs:
        Topic: quickstart-avro-config   Partition: 0    Leader: 3       Replicas: 3,1,2 Isr: 3,1,2
        Topic: quickstart-avro-config   Partition: 1    Leader: 1       Replicas: 1,2,3 Isr: 1,2,3
        Topic: quickstart-avro-config   Partition: 2    Leader: 2       Replicas: 2,3,1 Isr: 2,3,1
Topic:quickstart-avro-offsets   PartitionCount:3        ReplicationFactor:3     Configs:
        Topic: quickstart-avro-offsets  Partition: 0    Leader: 3       Replicas: 3,2,1 Isr: 3,2,1
        Topic: quickstart-avro-offsets  Partition: 1    Leader: 1       Replicas: 1,3,2 Isr: 1,3,2
        Topic: quickstart-avro-offsets  Partition: 2    Leader: 2       Replicas: 2,1,3 Isr: 2,1,3
Topic:quickstart-avro-status    PartitionCount:3        ReplicationFactor:3     Configs:
        Topic: quickstart-avro-status   Partition: 0    Leader: 1       Replicas: 1,2,3 Isr: 1,2,3
        Topic: quickstart-avro-status   Partition: 1    Leader: 2       Replicas: 2,3,1 Isr: 2,3,1
        Topic: quickstart-avro-status   Partition: 2    Leader: 3       Replicas: 3,1,2 Isr: 3,1,2
```

## Stoping CIGO

To stop CIGO, run the following script:

```
$> ./stop.sh
```

which can take some minutes to finish.
