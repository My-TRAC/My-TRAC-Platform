# CIGO

This repository contains all the scripts necessary to deploy the CIGO platform using both Docker Compose and Kubernetes. The CIGO platform is an event based, streaming platform based on [Confluent's platform](https://www.confluent.io/), that is extended to support the specific use case of Smart Cities and Smart Mobility applications. Such applications are typically composed by mobile apps (or apps in the edge) that generate a dense stream of data that must be processed and analyzed to reacted to in the cloud. 

## Core Components

The CIGO platform is composed by the following core components:
* An Apache Kafka cluster (with Zookeeper and Schema Registry)
* A Kafka-Connect cluster to ease the creation and integration of sink and source components
* Elastic Search (**under development**)
* Kibana (**under development**)

Additionally, an ontology with Smart City and Transportation concepts is (**currently under development**) is provided in order to standarize the different events that are injected to the platform. 

## Deployment types
Two deployment types are provided, one using [Docker Compose](cigo-deployment/README.md) and another one for [Kubernetes](cigo-kubernetes/README.md).

## Supported Kafka Connect plugins

This is the list of currently supported Kafka-Connect plugins
* mysql-connector-java-5.1.39
* elasticsearch-sink-connector-4.0.0
* hdfs-sink-connector-4.0.0
* hdfs-schema-source-connector-1.0.0-cp
* jdbc-sink-connector-4.0.0
* jdbc-source-connector-4.0.0
* s3-sink-connector-4.0.0
* storage-schema-source-connector-1.0.0-cp
* file-stream-sink-connector-1.0.0-cp
* file-stream-source-connector-1.0.0-cp
