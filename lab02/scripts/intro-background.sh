#!/bin/bash

groupadd cassandra
useradd -m -s /bin/bash -g cassandra cassandra-user

apt-get update

sudo apt-get install -y openjdk-11-jdk-headless < /dev/null > /dev/null 

# Downgrade Python to v3.11
# sudo apt remove python3.12
# sudo apt install python3.11 python3.11-venv python3.11-distutils
# sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1
# sudo update-alternatives --config python3

su cassandra-user 
cd /home/cassandra-user

curl https://dlcdn.apache.org/cassandra/5.0.4/apache-cassandra-5.0.4-bin.tar.gz \
        --output apache-cassandra-5.0.4-bin.tar.gz

tar xf apache-cassandra-5.0.4-bin.tar.gz

rm apache-cassandra-5.0.4-bin.tar.gz

mv apache-cassandra-5.0.4 cassandra

cd cassandra/bin

nohup ./cassandra -R > /tmp/cassandra.log 2>&1 &
