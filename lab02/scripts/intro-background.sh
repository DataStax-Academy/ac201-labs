#!/bin/bash

groupadd cassandra
useradd -m -s /bin/bash -g cassandra cassandra-user

cat <<'EOF' > /home/cassandra-user/.bash_profile
export PATH="/home/cassandra-user/cassandra/bin:$PATH"
cd /home/cassandra-user
export PS1="\w \$ "
EOF

chown cassandra-user:cassandra /home/cassandra-user/.bash_profile

apt-get update

sudo apt-get install -y openjdk-11-jdk-headless < /dev/null > /dev/null 

# Downgrade Python to v3.11
# Download prebuilt Python 3.11 binary from GitHub release
wget https://github.com/indygreg/python-build-standalone/releases/download/20240107/cpython-3.11.7+20240107-x86_64-unknown-linux-gnu-install_only.tar.gz

# Extract it
mkdir -p /opt/python3.11
tar -xzf cpython-3.11.7+20240107-x86_64-unknown-linux-gnu-install_only.tar.gz -C /opt/python3.11 --strip-components=1

sudo ln -sf /opt/python3.11/bin/python3.11 /usr/bin/python
sudo ln -sf /opt/python3.11/bin/pip3.11 /usr/bin/pip
sudo ln -sf /usr/local/bin/python3.11 /usr/bin/python3

# su cassandra-user 
# cd /home/cassandra-user

# curl https://dlcdn.apache.org/cassandra/5.0.4/apache-cassandra-5.0.4-bin.tar.gz \
#         --output apache-cassandra-5.0.4-bin.tar.gz

# tar xf apache-cassandra-5.0.4-bin.tar.gz

# rm apache-cassandra-5.0.4-bin.tar.gz

# mv apache-cassandra-5.0.4 cassandra

# cd cassandra/bin

# nohup ./cassandra -R > /tmp/cassandra.log 2>&1 &

su - cassandra-user -c '
  cd ~
  wget https://downloads.apache.org/cassandra/5.0.4/apache-cassandra-5.0.4-bin.tar.gz
  tar -xzf apache-cassandra-5.0.4-bin.tar.gz
  mv apache-cassandra-5.0.4 cassandra
'
su - cassandra-user -c '
  nohup ~/cassandra/bin/cassandra -R > ~/cassandra.log 2>&1 &
'
