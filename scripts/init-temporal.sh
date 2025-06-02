#!/bin/bash
set -e

# Run with correct -v and quoting
PGPASSWORD="$POSTGRES_PASSWORD" \
psql -v temporal_password="$TEMPORAL_PASSWORD" \
     -U "$POSTGRES_USER" -d postgres \
     -f /scripts/init-temporal.sql

echo "Temporal user and database created successfully"
