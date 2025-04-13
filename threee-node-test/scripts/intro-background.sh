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

#
# Download and extract Cassandra
#

su - cassandra-user -c '
  cd ~
  wget https://downloads.apache.org/cassandra/5.0.4/apache-cassandra-5.0.4-bin.tar.gz
  tar -xzf apache-cassandra-5.0.4-bin.tar.gz
  rm apache-cassandra-5.0.4-bin.tar.gz
  mv apache-cassandra-5.0.4 nodeA
  cp -r nodeA nodeB
  cp -r nodeA nodeC
'
#
# configure the yaml files
#

# Base IPs and ports
declare -A IPS=( [nodeA]=127.0.0.1 [nodeB]=127.0.0.2 [nodeC]=127.0.0.3 )
declare -A STORAGE_PORTS=( [nodeA]=7000 [nodeB]=7001 [nodeC]=7002 )
declare -A NATIVE_PORTS=( [nodeA]=9042 [nodeB]=9043 [nodeC]=9044 )
declare -A JMX_PORTS=( [nodeA]=7199 [nodeB]=7200 [nodeC]=7201 )

# Common settings
HOME_DIR="/home/cassandra-user"
CLUSTER_NAME="Academy Cluster"
SEED_IP="127.0.0.1"  # NodeA is the seed

for NODE in nodeA nodeB nodeC; do

  CONF_DIR="$HOME_DIR/$NODE/conf"
  YAML="$CONF_DIR/cassandra.yaml"
  ENV_SH="$CONF_DIR/cassandra-env.sh"

  # Set listen_address, rpc_address, ports, directories
  sed -i "s/^cluster_name:.*/cluster_name: '$CLUSTER_NAME'/" "$YAML"
  sed -i "s/^listen_address:.*/listen_address: ${IPS[$NODE]}/" "$YAML"
  sed -i "s/^rpc_address:.*/rpc_address: ${IPS[$NODE]}/" "$YAML"
  sed -i "s/^storage_port:.*/storage_port: ${STORAGE_PORTS[$NODE]}/" "$YAML"
  sed -i "s/^native_transport_port:.*/native_transport_port: ${NATIVE_PORTS[$NODE]}/" "$YAML"

  # Replace seed list block
  sed -i "/- seeds:/c\      - seeds: \"$SEED_IP\"" "$YAML"

  # Set data/log/cache directories
  sed -i "/^data_file_directories:/,/^ *[^-]/c\data_file_directories:\n    - .\/data" "$YAML"
  sed -i "s|^commitlog_directory:.*|commitlog_directory: ./commitlog|" "$YAML"
  sed -i "s|^saved_caches_directory:.*|saved_caches_directory: ./saved_caches|" "$YAML"

  # Set JMX port in cassandra-env.sh
  sed -i "s/^JVM_OPTS=\"\$JVM_OPTS -Dcom.sun.management.jmxremote.port=.*/JVM_OPTS=\"\$JVM_OPTS -Dcom.sun.management.jmxremote.port=${JMX_PORTS[$NODE]}\"/" "$ENV_SH"

  # Create data directories
  mkdir -p "$HOME_DIR/$NODE/data" "$HOME_DIR/$NODE/commitlog" "$HOME_DIR/$NODE/saved_caches"
done

#
# Start the nodes in the background
#

su - cassandra-user -c '
  mkdir -p ~/logs/nodeA
  mkdir -p ~/logs/nodeB
  mkdir -p ~/logs/nodeC
  nohup ~/nodeA/bin/cassandra -R > ~/logs/nodeA/cassandra.log 2>&1 &
  nohup ~/nodeB/bin/cassandra -R > ~/logs/nodeB/cassandra.log 2>&1 &
  nohup ~/nodeC/bin/cassandra -R > ~/logs/nodeC/cassandra.log 2>&1 &
'
