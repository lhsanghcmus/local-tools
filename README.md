# local-tools

A Docker Compose-based local development environment that provides essential data storage and messaging services for development and testing purposes.

## Description

This project sets up a comprehensive local development stack with the following services:

### 📊 Database Services
- **MongoDB Replica Set**: A 3-node MongoDB cluster (Primary, Secondary, Arbiter) with authentication and keyfile security
- **Redis**: In-memory data structure store with persistence and password protection

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
| Kafka Broker 0 | 9992 | First Kafka broker |
| Kafka Broker 1 | 9993 | Second Kafka broker |
| Kafka Broker 2 | 9994 | Third Kafka broker |
| Kafka UI | 8080 | Web interface for Kafka management |

## Quick Start

### Prerequisites
- Docker and Docker Compose installed
- Environment variables for MongoDB and Redis authentication

### Setup Environment Variables
Create a `.env` file with the following variables:
```bash
MONGO_INITDB_ROOT_USERNAME=your_mongo_username
MONGO_INITDB_ROOT_PASSWORD=your_mongo_password
REDIS_PASSWORD=your_redis_password
```

### Usage
```bash
# Install all services
make up

# Uninstall all services
make down
```


## Data Persistence

All data is persisted in the `./data/` directory:
- `./data/mongodb_primary/` - MongoDB data
- `./data/redis/` - Redis data
- `./data/kafka0/`, `./data/kafka1/`, `./data/kafka2/` - Kafka data

## Features

- **Production-like Setup**: MongoDB replica set and Kafka cluster mimic production environments
- **Persistent Storage**: Data survives container restarts
- **Security**: MongoDB uses keyfile authentication, Redis requires password
- **Web UI**: Kafka UI provides easy topic and consumer management
- **Easy Management**: Simple make commands for lifecycle management

## Use Cases

Perfect for:
- Local development requiring MongoDB, Redis, and Kafka
- Testing distributed applications
- Learning about replica sets and Kafka clusters
- Prototyping event-driven architectures
- Integration testing with multiple data stores
