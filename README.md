## Attribution

This project is based on
[finance-tracker-api](https://github.com/Franklindot04/finance-tracker-api)
by Ajero Franklin (Franklindot04), licensed under the MIT License.

Modifications and deployment configuration are maintained by ROXANA-IULIA MIU.

# Finance Tracker API 📊

Production-ready FastAPI backend with Proxmox VE, Terraform, Prometheus and Grafana.

A lightweight, modular and production-ready FastAPI backend for tracking personal expenses. The application is containerized with Docker and designed to run in a self-hosted Proxmox environment, with infrastructure managed by Terraform and observability provided by Prometheus and Grafana.

This project demonstrates real-world DevOps practices:

- Infrastructure as Code with Terraform
- Containerization with Docker
- Self-hosted virtualization with Proxmox VE
- Secure network segmentation between application, database and monitoring services
- Metrics collection with Prometheus
- Dashboards and visualization with Grafana
- CI/CD-ready architecture

---

## 📚 Table of Contents

- [Built With](#-built-with)
- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [High-Level Architecture](#-high-level-architecture)
- [Project Structure](#-project-structure)
- [Authentication Flow](#-authentication-flow)
- [API Endpoints](#-api-endpoints)
- [Example cURL Commands](#-example-curl-commands)
- [Running Locally with Docker](#-running-locally-with-docker)
- [Running Locally without Docker](#-running-locally-without-docker)
- [Environment Variables](#-environment-variables)
- [Proxmox Infrastructure with Terraform](#-proxmox-infrastructure-with-terraform)
- [Deploying to Proxmox](#-deploying-to-proxmox)
- [Prometheus and Grafana](#-prometheus-and-grafana)
- [Security Considerations](#-security-considerations)
- [Troubleshooting](#-troubleshooting)
- [Proxmox Cleanup Guide](#-proxmox-cleanup-guide)
- [Future Improvements](#-future-improvements)
- [License](#-license)

---

## 🧰 Built With

![Python](https://img.shields.io/badge/Python-3.11-blue?logo=python&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-0.110-009688?logo=fastapi&logoColor=white)
![SQLite](https://img.shields.io/badge/SQLite-3-003B57?logo=sqlite&logoColor=white)
![SQLAlchemy](https://img.shields.io/badge/SQLAlchemy-2.0-red?logo=python&logoColor=white)
![Pydantic](https://img.shields.io/badge/Pydantic-v2-ef4444?logo=pydantic&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Containerized-2496ED?logo=docker&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-IaC-844FBA?logo=terraform&logoColor=white)
![Proxmox](https://img.shields.io/badge/Proxmox-VE-E57000?logo=proxmox&logoColor=white)
![Prometheus](https://img.shields.io/badge/Prometheus-Monitoring-E6522C?logo=prometheus&logoColor=white)
![Grafana](https://img.shields.io/badge/Grafana-Dashboards-F46800?logo=grafana&logoColor=white)

---

## 🚀 Features

- JWT-based authentication with registration and login
- CRUD operations for expenses
- SQLite for local development and PostgreSQL for production deployments
- Modular FastAPI architecture (`api`, `core`, `models`, `schemas`)
- Dockerfile and Docker Compose configuration
- Interactive Swagger UI at `/docs`
- Self-hosted deployment in Proxmox VMs or LXC containers
- Infrastructure managed with Terraform
- Prometheus metrics collection and Grafana dashboards
- Reverse proxy support with NGINX or Traefik
- Monitoring and alerting-friendly deployment model

---

## 🛠️ Tech Stack

### Backend

- FastAPI
- Python 3.11
- SQLAlchemy ORM
- Pydantic v2
- Uvicorn

### Infrastructure and Operations

- Proxmox VE
- Terraform
- Docker / Docker Compose
- PostgreSQL
- Prometheus
- Grafana
- Node Exporter
- cAdvisor
- Optional NGINX / Traefik reverse proxy

---

## 🏗️ High-Level Architecture

This project is designed for a self-hosted Proxmox environment, where application services, databases and monitoring are separated into different VMs or containers.

```text
Users / LAN
    |
    v
Reverse Proxy (NGINX or Traefik)
    |
    v
FastAPI Application (Docker container / VM)
    |
    v
PostgreSQL Database (VM or container)

Monitoring Stack
    ├── Prometheus
    │   ├── FastAPI /metrics
    │   ├── Node Exporter
    │   └── cAdvisor
    └── Grafana
        └── Dashboards and alert visualization
