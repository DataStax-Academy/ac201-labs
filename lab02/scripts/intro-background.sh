#!/bin/bash

groupadd cassandra
useradd -m -s /bin/bash -g cassandra cassandra-user

apt-get update

sudo apt-get install -y openjdk-11-jdk-headless < /dev/null > /dev/null 

# Downgrade Python to v3.11
# Download prebuilt Python 3.11 binary from GitHub release
wget https://github.com/indygreg/python-build-standalone/releases/download/20240107/cpython-3.11.7+20240107-x86_64-unknown-linux-gnu-install_only.tar.gz

# Extract it
mkdir -p /opt/python3.11
tar -xzf cpython-3.11.7+20240107-x86_64-unknown-linux-gnu-install_only.tar.gz -C /opt/python3.11 --strip-components=1

# sudo ln -sf /opt/python3.11/bin/python /usr/bin/python


# # Optionally symlink it
# ln -s /opt/python3.11/bin/python /usr/local/bin/python3.11
# ln -s /opt/python3.11/bin/pip /usr/local/bin/pip3.11

su cassandra-user 
cd /home/cassandra-user

curl https://dlcdn.apache.org/cassandra/5.0.4/apache-cassandra-5.0.4-bin.tar.gz \
        --output apache-cassandra-5.0.4-bin.tar.gz

tar xf apache-cassandra-5.0.4-bin.tar.gz

rm apache-cassandra-5.0.4-bin.tar.gz

mv apache-cassandra-5.0.4 cassandra

cd cassandra/bin

nohup ./cassandra -R > /tmp/cassandra.log 2>&1 &
