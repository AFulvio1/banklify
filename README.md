# Banklify - Demo Environment 🏦

Welcome to the orchestration repository for the **Banklify** demo.
This project uses **Docker Compose** to instantiate the entire application stack (Frontend, Backend, and Database) in seconds, utilizing pre-compiled images and a pre-populated database.

## 🏗️ Architecture & Components

The system consists of three orchestrated containers communicating over a dedicated Docker network (`bank-network`):

| Component | Technology             | Source Repository | Docker Image (GHCR) |
| :--- |:-----------------------| :--- | :--- |
| **Frontend** | React (Vite) + Nginx   | [AFulvio1/banklify-frontend](https://github.com/AFulvio1/banklify-frontend) | `ghcr.io/afulvio1/banklify-frontend:main` |
| **Backend** | Spring Boot (Java 21)  | [AFulvio1/banklify-backend](https://github.com/AFulvio1/banklify-backend) | `ghcr.io/afulvio1/banklify-backend:main` |
| **Database** | PostgreSQL 17 (Alpine) | *N/A (Official Image)* | `postgres:17-alpine` |

---

## 🚀 Quick Start Guide

### Prerequisites
* [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running.
* Git (optional, to clone the repo).

### Installation

1.  **Clone this repository** (or download the zip):
    ```bash
    git clone https://github.com/AFulvio1/banklify-demo.git
    cd banklify-demo
    ```

2.  **Start the environment**:
    Run the following command in the folder where the `docker-compose.yml` file is located:
    ```bash
    docker compose up -d
    ```
    *The first startup may take a few minutes to download the images and initialize the database with the included dump.*

3.  **Access the Application**:
    Open your browser and go to:
    👉 **[http://localhost:3000](http://localhost:3000)**

---

## 🔐 Credentials & Configuration

### Database (PostgreSQL)
The database is automatically initialized by importing the `dump-banklify-db.sql` file.
If you wish to connect to the DB with an external client (e.g., DBeaver), use these parameters:

* **Host:** `localhost`
* **Port:** `5433` (Note: mapped to 5433 to avoid conflicts with any local Postgres on 5432)
* **Database:** `banklify-db`
* **Username:** `banklify_user`
* **Password:** `banklifypassword`

### Demo Users
You can register a new user directly from the **Registration** page of the application, or use this user:

| Email                       | Password |
|:----------------------------|:---------|
| **mario.rossi@banklify.it** | password |


---

## 🛠️ Useful Commands

**Update Images**
If new versions of the Backend or Frontend have been released on the source repositories, you can update the demo with:
```bash
docker compose pull
docker compose up -d