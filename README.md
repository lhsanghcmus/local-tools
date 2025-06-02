# local-tools

A Docker Compose-based local development environment that provides essential data storage and messaging services for development and testing purposes.

## 📋 Release Notes & Changelog

For detailed information about changes, new features, and version history, see [CHANGELOG.md](CHANGELOG.md).

## Description

This project sets up a comprehensive local development stack with the following services:

### 📊 Database Services
- **MongoDB Replica Set**: A 3-node MongoDB cluster (Primary, Secondary, Arbiter) with authentication and keyfile security
- **Redis**: In-memory data structure store with persistence and password protection
- **PostgreSQL**: PostgreSQL database with Temporal workflow database setup

### 📨 Messaging Services
- **Apache Kafka Cluster**: A 3-broker Kafka cluster using KRaft mode (without Zookeeper)
- **Kafka UI**: Web-based interface for managing and monitoring Kafka topics, consumers, and producers (no password required)

### 🔍 Search & Analytics Services
- **Elasticsearch**: Distributed search and analytics engine with security enabled
- **Kibana**: Web-based interface for Elasticsearch data visualization and analysis

### 🔄 Workflow Services
- **Temporal Server**: Distributed workflow orchestration platform for reliable microservices
- **Temporal UI**: Web-based interface for monitoring and managing Temporal workflows

## Services & Ports

| Service | Port | Description |
|---------|------|-------------|
| MongoDB Primary | 30000 | Main MongoDB instance |
| MongoDB Secondary | 30001 | Secondary MongoDB replica |
| MongoDB Arbiter | 30002 | MongoDB arbiter node |
| Redis | 6379 | Redis server |
| PostgreSQL | 5432 | PostgreSQL database server |
| Temporal Server | 7233 | Temporal gRPC endpoint |
| Temporal UI | 8090 | Web interface for Temporal workflows (no login required) |
| Kafka Broker 0 | 9992 | First Kafka broker |
| Kafka Broker 1 | 9993 | Second Kafka broker |
| Kafka Broker 2 | 9994 | Third Kafka broker |
| Kafka UI | 8080 | Web interface for Kafka management (no login required) |
| Elasticsearch | 9200 | Elasticsearch REST API |
| Kibana | 5601 | Web interface for Elasticsearch visualization |

## Quick Start

### Prerequisites
- Docker and Docker Compose installed
- Environment variables for database authentication

### Setup Script Permissions
After cloning the repository, make sure the script files have execute permissions:
```bash
chmod +x scripts/up.sh
chmod +x scripts/down.sh
chmod +x scripts/init-temporal.sh
chmod +x scripts/create-kibana.user.sh
```

### Setup Environment Variables
Create a `.env` file with the following variables:
```bash
# MongoDB Configuration
MONGO_INITDB_ROOT_USERNAME=your_mongo_username
MONGO_INITDB_ROOT_PASSWORD=your_mongo_password

# Redis Configuration
REDIS_PASSWORD=your_redis_password

# PostgreSQL Configuration
POSTGRES_USER=your_postgres_username
POSTGRES_PASSWORD=your_postgres_password
TEMPORAL_PASSWORD=your_temporal_password

# Elasticsearch Configuration
ES_PASSWORD=your_elasticsearch_password
KIBANA_USER=kibana_system
KIBANA_PASSWORD=your_kibana_password
```

### Usage
```bash
# Start all services
make up

# Stop all services
make down

# Alternative: Using docker compose directly
docker compose up -d
docker compose down -v
```

## Data Persistence

All data is persisted in the `./data/` directory:
- `./data/mongodb_primary/` - MongoDB data
- `./data/redis/` - Redis data
- `./data/kafka0/`, `./data/kafka1/`, `./data/kafka2/` - Kafka data
- `./data/postgresql/` - PostgreSQL data
- `./data/elasticsearch/` - Elasticsearch data

## Service Details

### MongoDB Replica Set
- **Primary**: Main read/write instance on port 30000
- **Secondary**: Replica instance on port 30001  
- **Arbiter**: Voting member for elections on port 30002
- **Authentication**: Uses keyfile-based internal authentication
- **Version**: MongoDB Community Server 8.0.4

### Redis
- **Version**: Redis 8.0.1 Alpine
- **Persistence**: RDB snapshots every 20 seconds if at least 1 key changed
- **Security**: Password protected

### PostgreSQL
- **Version**: PostgreSQL 17
- **Features**: Standard PostgreSQL database
- **Temporal Setup**: Includes Temporal workflow database initialization

### Temporal Server
- **Version**: Temporalio Auto-setup 1.27.2
- **Database**: Uses PostgreSQL as persistence layer
- **Features**: Full workflow orchestration with automatic database setup
- **Authentication**: Connects to dedicated `temporal` database and `temporal_visibility` database
- **Security**: No authentication required for client connections

### Temporal UI
- **Version**: Temporalio UI v2.37.3
- **Features**: Web-based workflow monitoring, execution history, and task management
- **CORS**: Configured to allow connections from localhost:3000
- **Security**: No authentication required for web access

### Kafka Cluster
- **Version**: Confluent Platform 7.9.1
- **Mode**: KRaft (no Zookeeper dependency)
- **Brokers**: 3-node cluster for high availability
- **UI**: Provectus Kafka UI v0.7.2 for management
- **Security**: No authentication required for client connections or web UI access

### Elasticsearch
- **Version**: Elasticsearch 9.0.1
- **Mode**: Single-node cluster for development
- **Security**: X-Pack security enabled with password authentication
- **Features**: Full-text search, analytics, and aggregations
- **Memory**: Configured with 1GB heap size (ES_JAVA_OPTS)

### Kibana
- **Version**: Kibana 9.0.1
- **Authentication**: Uses dedicated `kibana_system` user
- **Features**: Data visualization, dashboard creation, and Elasticsearch management
- **Configuration**: Custom configuration via `kibana.yaml`

## Features

- **Production-like Setup**: MongoDB replica set and Kafka cluster mimic production environments
- **Persistent Storage**: Data survives container restarts with local bind mounts
- **Security**: MongoDB uses keyfile authentication, Redis and PostgreSQL require passwords
- **Web UI**: Kafka UI and Temporal UI provide easy management interfaces
- **Easy Management**: Simple make commands for lifecycle management
- **Workflow Orchestration**: Full Temporal platform for distributed workflow management

## Use Cases

Perfect for:
- Local development requiring MongoDB, Redis, PostgreSQL, and Kafka
- Testing distributed applications and microservices
- Learning about replica sets and Kafka clusters
- Prototyping event-driven architectures
- Integration testing with multiple data stores
- Temporal workflow development
- Search and analytics with Elasticsearch and Kibana
- Log aggregation and visualization

## Connection Examples

### MongoDB
```bash
# Connect to primary
mongosh mongodb://username:password@localhost:30000/admin?replicaSet=rs0

# Connect to secondary (read-only)
mongosh mongodb://username:password@localhost:30001/admin?replicaSet=rs0&readPreference=secondary
```

### Redis
```bash
# Connect with password
redis-cli -h localhost -p 6379 -a your_redis_password
```

### PostgreSQL
```bash
# Connect with psql
psql -h localhost -p 5432 -U your_postgres_username -d postgres
```

### Temporal
```bash
# Use Temporal CLI (if you have it installed) - no authentication required
temporal --address localhost:7233 workflow list

# Or access the web UI at http://localhost:8090 (no login required)
```

### Kafka
```bash
# List topics (if you have kafka tools installed) - no authentication required
kafka-topics --bootstrap-server localhost:9992 --list

# Or use the web UI at http://localhost:8080 (no login required)
```

### Elasticsearch
```bash
# Check cluster health with authentication
curl -u elastic:your_elasticsearch_password http://localhost:9200/_cluster/health

# Create an index
curl -u elastic:your_elasticsearch_password -X PUT http://localhost:9200/my-index

# Search documents
curl -u elastic:your_elasticsearch_password http://localhost:9200/my-index/_search

# Or use Kibana web UI at http://localhost:5601 (login with kibana_system user)
```
