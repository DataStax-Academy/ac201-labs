#!/bin/bash

groupadd cassandra
useradd -m -s /bin/bash -g cassandra cassandra-user

apt-get update

sudo apt-get install -y openjdk-11-jdk-headless < /dev/null > /dev/null 

su cassandra-user
cd /home/cassandra-user
curl https://dlcdn.apache.org/cassandra/5.0.4/apache-cassandra-5.0.4-bin.tar.gz \
        --output apache-cassandra-5.0.4-bin.tar.gz
tar xf apache-cassandra-5.0.4-bin.tar.gz
rm apache-cassandra-5.0.4-bin.tar.gz
mv apache-cassandra-5.0.4 cassandra
cd cassandra/bin




