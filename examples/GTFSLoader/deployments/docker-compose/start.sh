#!/bin/bash

eval $(docker-machine env cigo)                                                                                                       
docker-compose up -d
