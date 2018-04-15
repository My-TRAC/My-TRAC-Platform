# CIGO on KUBERNETES
## Requirements
Kubernetes is a framework for managing the scaling of containerized applications on clusters. However, you do not need a cluster to deploy and test the CIGO platform. One can use [Minikube](https://kubernetes.io/docs/getting-started-guides/minikube/), which creates a virtual cluster locally to be used with Kubernetes. 

Besides Minikube, you also need to [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/), which is the commmand line tool to control a Kubernetes cluster (or Minikube) locally.

Once Minikube and Kubectl are installed, run the following command to configure Minikube and start the "fake" cluster:

```
minikube start
```

## Deploy the CIGO platform on KUBERNETES

```
$> ./start.sh
```
If everything went,the command `kubectl get pods` should prdouce an output similar to the following

```
NAME                                   READY     STATUS    RESTARTS   AGE
cigo-kafka-0                           1/1       Running   0          1s
cigo-kafka-connect-7bdd5d6664-w2ckl    1/1       Running   0          1s
cigo-schema-registry-59cfd87f8-9gkmj   1/1       Running   0          1s
cigo-zookeeper-0                       1/1       Running   0          1s
```

## Stopping CIGO

To stop CIGO, run the following script:

```
$> ./stop.sh
```

which can take some minutes to finish. Additionally, you can stop Minikube and optionally delete the cluster using the following commands:

```
minikube stop && minikube delete
```
