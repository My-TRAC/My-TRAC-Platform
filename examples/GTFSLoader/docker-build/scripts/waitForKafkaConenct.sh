#!/bin/bash

printf "%s" "waiting for Kafka-Connect ..."
while ! ping -c 1 -n -w 1 kafka-connect &> /dev/null
do
	sleep 1
    printf "%c" "Trying to connect to kafka-connect"
done
printf "\n%s\n"  "Kafka-Connect is online"

