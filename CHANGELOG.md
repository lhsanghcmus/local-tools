# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.1] - 2025-06-03

### Fixed
- **Setup Script Instructions**: Fixed typo in README.md setup instructions
  - Corrected script filename from `scripts/create-kibana.user.sh` to `scripts/create-kibana-user.sh`
  - Added missing `chmod 400 scripts/mongosetup/mongo-keyfile` command for MongoDB keyfile permissions
  - Ensures proper file permissions for MongoDB authentication setup

## [1.0.0] - 2025-06-02

### Added
- **Elasticsearch & Kibana Services**: Added Elasticsearch 9.0.1 and Kibana 9.0.1 for search and analytics capabilities
  - Single-node Elasticsearch cluster with X-Pack security enabled
  - Kibana web interface for data visualization and Elasticsearch management
  - Persistent storage for Elasticsearch data
  - Authentication with dedicated `kibana_system` user
  - Port mappings: Elasticsearch (9200), Kibana (5601)

- **Temporal Workflow Platform**: Complete Temporal setup for distributed workflow orchestration
  - Temporal Server 1.27.2 with automatic database setup
  - Temporal UI v2.37.3 for workflow monitoring and management
  - PostgreSQL integration for persistence layer
  - Dedicated `temporal` and `temporal_visibility` databases
  - Port mappings: Temporal Server (7233), Temporal UI (8090)
  - CORS configuration for localhost:3000 integration

- **PostgreSQL Database**: PostgreSQL 17 database server
  - Standard PostgreSQL database functionality
  - Temporal workflow database initialization
  - Persistent storage with local bind mounts
  - Authentication with username/password
  - Port mapping: 5432

- **Comprehensive Docker Compose Setup**: Multi-service local development environment
  - MongoDB Replica Set (3-node cluster with Primary, Secondary, Arbiter)
  - Redis 8.0.1 with password protection and persistence
  - Kafka Cluster (3-broker KRaft mode without Zookeeper)
  - Kafka UI v0.7.2 for cluster management
  - All services with persistent data storage

### Features
- **Production-like Setup**: MongoDB replica set and Kafka cluster mimic production environments
- **Security Configuration**: 
  - MongoDB keyfile-based internal authentication
  - Redis password protection
  - PostgreSQL username/password authentication
  - Elasticsearch X-Pack security with password authentication
- **Web Interfaces**: 
  - Kafka UI (port 8080) - no authentication required
  - Temporal UI (port 8090) - no authentication required  
  - Kibana (port 5601) - authentication required
- **Data Persistence**: All services store data in `./data/` directory with local bind mounts
- **Easy Management**: Simple make commands (`make up`, `make down`) for lifecycle management

### Infrastructure
- **Service Ports**:
  - MongoDB: 30000 (Primary), 30001 (Secondary), 30002 (Arbiter)
  - Redis: 6379
  - PostgreSQL: 5432
  - Temporal: 7233 (Server), 8090 (UI)
  - Kafka: 9992-9994 (Brokers), 8080 (UI)
  - Elasticsearch: 9200
  - Kibana: 5601

- **Scripts & Automation**:
  - `scripts/up.sh` - Start all services
  - `scripts/down.sh` - Stop all services
  - `scripts/init-temporal.sh` - Initialize Temporal databases
  - `scripts/create-kibana-user.sh` - Setup Kibana authentication
  - MongoDB setup scripts in `scripts/mongosetup/`

### Documentation
- Comprehensive README.md with:
  - Service descriptions and port mappings
  - Quick start guide with environment variable setup
  - Connection examples for all services
  - Use cases and features overview
  - Data persistence information

---

## Version History Notes

This project follows semantic versioning:
- **MAJOR** version for incompatible API changes or major infrastructure changes
- **MINOR** version for backwards-compatible functionality additions
- **PATCH** version for backwards-compatible bug fixes

To create a new release:
1. Update this CHANGELOG.md file
2. Create a git tag: `git tag -a v1.0.0 -m "Release version 1.0.0"`
3. Push the tag: `git push origin v1.0.0` 
