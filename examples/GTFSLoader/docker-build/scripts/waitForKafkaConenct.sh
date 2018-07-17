#!/bin/bash

printf "%s" "waiting for ServerXY ..."
while ! ping -c 1 -n -w 1 kafka-connect &> /dev/null
do
    printf "%c" "."
done
printf "\n%s\n"  "Kafka-Connect is online"

