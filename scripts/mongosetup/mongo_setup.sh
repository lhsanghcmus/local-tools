#!/bin/bash

# Wait for the primary to be up and accepting connections
until mongosh --host mongodb-primary:30000 --username admin --password adminpassword123 --authenticationDatabase admin --quiet --eval "db.adminCommand('ping')" >/dev/null 2>&1; do
  echo "Waiting for mongodb-primary to be ready..."
  sleep 3
done

# Create replica set configuration
mongosh --host mongodb-primary:30000 --username admin --password adminpassword123 --authenticationDatabase admin <<EOF
use admin;
var cfg = {
  _id: "rs0",
  version: 1,
  members: [
    { _id: 0, host: "mongodb-primary:30000", priority: 2 },
    { _id: 1, host: "mongodb-secondary:30001", priority: 0 },
    { _id: 2, host: "mongodb-arbiter:30002", arbiterOnly: true}
  ]
};
rs.initiate(cfg);
EOF
