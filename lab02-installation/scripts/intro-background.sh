#!/bin/bash

groupadd cassandra
useradd -m -s /bin/bash -g cassandra cassandra-user

apt-get update

sudo apt-get install -y openjdk-11-jdk-headless < /dev/null > /dev/null 


