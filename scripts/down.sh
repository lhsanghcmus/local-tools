#!/bin/sh -e

# Resolve the directory of the script
SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# Run docker compose down from project root
docker compose -f "$SCRIPT_DIR/../docker-compose.yml" down -v