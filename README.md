# local-tools

A Docker Compose-based local development environment that provides essential data storage and messaging services for development and testing purposes.

## Description

This project sets up a comprehensive local development stack with the following services:

### 📊 Database Services
- **MongoDB Replica Set**: A 3-node MongoDB cluster (Primary, Secondary, Arbiter) with authentication and keyfile security
- **Redis**: In-memory data structure store with persistence and password protection
- **TimescaleDB**: PostgreSQL-based time-series database with Temporal workflow database setup

### 📨 Messaging Services
- **Apache Kafka Cluster**: A 3-broker Kafka cluster using KRaft mode (without Zookeeper)
- **Kafka UI**: Web-based interface for managing and monitoring Kafka topics, consumers, and producers

## Services & Ports

| Service | Port | Description |
|---------|------|-------------|
| MongoDB Primary | 30000 | Main MongoDB instance |
| MongoDB Secondary | 30001 | Secondary MongoDB replica |
| MongoDB Arbiter | 30002 | MongoDB arbiter node |
| Redis | 6379 | Redis server |
| TimescaleDB | 5432 | PostgreSQL with TimescaleDB extensions |
| Kafka Broker 0 | 9992 | First Kafka broker |
| Kafka Broker 1 | 9993 | Second Kafka broker |
| Kafka Broker 2 | 9994 | Third Kafka broker |
| Kafka UI | 8080 | Web interface for Kafka management |

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
```

### Setup Environment Variables
Create a `.env` file with the following variables:
```bash
# MongoDB Configuration
MONGO_INITDB_ROOT_USERNAME=your_mongo_username
MONGO_INITDB_ROOT_PASSWORD=your_mongo_password

# Redis Configuration
REDIS_PASSWORD=your_redis_password

# TimescaleDB/PostgreSQL Configuration
POSTGRES_USER=your_postgres_username
POSTGRES_PASSWORD=your_postgres_password
TEMPORAL_PASSWORD=your_temporal_password
```

### Usage
```bash
# Start all services
make up

# Stop all services
make down

# Alternative: Using docker compose directly
docker compose up -d
docker compose down
```

## Data Persistence

All data is persisted in the `./data/` directory:
- `./data/mongodb_primary/` - MongoDB data
- `./data/redis/` - Redis data
- `./data/kafka0/`, `./data/kafka1/`, `./data/kafka2/` - Kafka data
- `./data/timescaledb/` - TimescaleDB/PostgreSQL data

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

### TimescaleDB
- **Version**: TimescaleDB 2.20.1 with PostgreSQL 17
- **Features**: Time-series extensions enabled
- **Temporal Setup**: Includes Temporal workflow database initialization

### Kafka Cluster
- **Version**: Confluent Platform 7.9.1
- **Mode**: KRaft (no Zookeeper dependency)
- **Brokers**: 3-node cluster for high availability
- **UI**: Provectus Kafka UI v0.7.2 for management

## Features

- **Production-like Setup**: MongoDB replica set and Kafka cluster mimic production environments
- **Persistent Storage**: Data survives container restarts with local bind mounts
- **Security**: MongoDB uses keyfile authentication, Redis and PostgreSQL require passwords
- **Web UI**: Kafka UI provides easy topic and consumer management
- **Easy Management**: Simple make commands for lifecycle management
- **Time-series Ready**: TimescaleDB for time-series data and Temporal workflows

## Use Cases

Perfect for:
- Local development requiring MongoDB, Redis, PostgreSQL, and Kafka
- Testing distributed applications and microservices
- Learning about replica sets and Kafka clusters
- Prototyping event-driven architectures
- Integration testing with multiple data stores
- Time-series data applications
- Temporal workflow development

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

### TimescaleDB
```bash
# Connect with psql
psql -h localhost -p 5432 -U your_postgres_username -d postgres
```

### Kafka
```bash
# List topics (if you have kafka tools installed)
kafka-topics --bootstrap-server localhost:9992 --list

# Or use the web UI at http://localhost:8080
```
