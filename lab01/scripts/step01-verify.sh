#!/bin/bash

# Expected values
EXPECTED_USER="cassandra-user"
EXPECTED_DIR="/home/cassandra-user"

# Check user
if [ "$USER" != "$EXPECTED_USER" ]; then
  echo "Error: This script must be run as '$EXPECTED_USER'."
  exit 1
fi

# Check directory
if [ "$PWD" != "$EXPECTED_DIR" ]; then
  echo "Error: You must be in the directory '$EXPECTED_DIR'."
  exit 1
fi
