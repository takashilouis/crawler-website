# Crawler system
![Crawler system architecture](public/crawler-system-architecture.png)

# 🕷️ Crawler System Architecture

![Crawler Architecture](public/crawler-system-architecture.png)

This system is designed to crawl data from websites, store and stream the information through a scalable pipeline, and make it searchable via Elasticsearch. Below is a detailed explanation of each component involved in the data flow.

---

## 🔄 System Flow Overview

### 1. Website & Crawler
- The **crawler** retrieves data from websites in real-time or on a schedule.
- It pushes raw data into a **Redis Stream**, enabling decoupled and asynchronous message processing.

### 2. Redis Stream → Consumer
- **Redis Stream** acts as a lightweight message queue.
- A **consumer** listens to new stream entries, processes the data, and writes it into **PostgreSQL**.

### 3. PostgreSQL
- This is the primary database for storing structured post data.
- The API layer retrieves data from here through the `/posts` endpoint.
- Changes to this database are captured by **Debezium**.

### 4. Kafka Connect + Debezium
- **Debezium Postgres Connector** captures inserts/updates from Postgres and publishes them to a **Kafka topic**.
- **Debezium Elasticsearch Connector** subscribes to that Kafka topic and updates **Elasticsearch** accordingly.

### 5. Elasticsearch
- Optimized for full-text search.
- The system exposes a `/posts/search` endpoint to perform fast queries over indexed content.

### 6. API Service
- Central service that serves both `/posts` (from Postgres) and `/posts/search` (from Elasticsearch).
- Acts as the backend for the **Website**, delivering both recent and searchable content.

---

## 🧱 Technology Stack

| Component            | Technology                        |
|----------------------|------------------------------------|
| Crawling             | Python (Scrapy, Puppeteer, etc.)   |
| Messaging Queue      | Redis Stream                       |
| Database             | PostgreSQL                         |
| Change Data Capture  | Debezium                           |
| Streaming Platform   | Apache Kafka                       |
| Search Engine        | Elasticsearch                      |
| Backend API          | FastAPI / Express.js (custom)      |
| Frontend             | Website consuming REST APIs        |

---

## ✨ Features

- Real-time website data crawling
- Stream-based ingestion pipeline
- Event-driven updates to search index
- Dual-database architecture: Postgres for transactional data, Elasticsearch for search
- Scalable and modular design using Kafka Connect

---

## 🔧 Future Improvements

- Add rate limiting and retry logic to the crawler
- Implement deduplication in the consumer logic
- Deploy system using Docker and Kubernetes
- Integrate monitoring (e.g., Prometheus + Grafana)
