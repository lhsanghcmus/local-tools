#!/bin/sh
set -e

ELASTIC_USER=${ELASTIC_USER:-elastic}
ELASTIC_PASSWORD=${ELASTIC_PASSWORD}
ES_HOST=${ES_HOST:-http://elasticsearch:9200}
KIBANA_PASSWORD=${KIBANA_PASSWORD:-kibana123}

echo "Waiting for Elasticsearch to be ready..."

until curl -s -u "$ELASTIC_USER:$ELASTIC_PASSWORD" "$ES_HOST/_cluster/health" | grep -q '"status":"green"'; do
  echo "Waiting..."
  sleep 5
done

echo "Setting password for built-in user 'kibana_system'..."

curl -u "$ELASTIC_USER:$ELASTIC_PASSWORD" -X POST "$ES_HOST/_security/user/kibana_system/_password" \
  -H "Content-Type: application/json" \
  -d "{
    \"password\": \"$KIBANA_PASSWORD\"
  }"

echo "Password for 'kibana_system' set."
