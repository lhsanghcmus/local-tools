#!/bin/bash
set -e

# Wait for PostgreSQL to be ready
until pg_isready -h localhost -p 5432 -U "$POSTGRES_USER"; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 2
done

# Run the SQL script with password substitution
PGPASSWORD="$POSTGRES_PASSWORD" psql -v temporal_password="'$TEMPORAL_PASSWORD'" -U "$POSTGRES_USER" -d postgres -f /docker-entrypoint-initdb.d/init-temporal.sql

echo "Temporal user and database created successfully" 