#!/bin/sh -e

# Resolve script directory
SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

mkdir -p "$SCRIPT_DIR/../data/kafka0"
mkdir -p "$SCRIPT_DIR/../data/kafka1"
mkdir -p "$SCRIPT_DIR/../data/kafka2"
mkdir -p "$SCRIPT_DIR/../data/mongodb_primary"
mkdir -p "$SCRIPT_DIR/../data/redis"
mkdir -p "$SCRIPT_DIR/../data/postgres"
mkdir -p "$SCRIPT_DIR/../data/elasticsearch"

# Run Docker Compose from the project root
docker compose -f "$SCRIPT_DIR/../docker-compose.yml"  up -d
