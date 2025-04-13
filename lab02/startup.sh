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

# Optional: print to Killercoda info panel
echo "Starting Cassandra..." > /dev/tty 2>&1

# Start Cassandra in the background
nohup cassandra -R > /tmp/cassandra.log 2>&1 &

# Wait for Cassandra to be available
until cqlsh -e "DESCRIBE KEYSPACES;" > /dev/null 2>&1; do
  echo "Waiting for Cassandra to start..." > /dev/tty 2>&1
  sleep 2
done

echo "Cassandra is ready!" > /dev/tty 2>&1