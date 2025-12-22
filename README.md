# AWS Nginx Load Balancing with Private Backends and Failover
![NGINX-Logo](https://github.com/user-attachments/assets/9d1413ad-74d7-4b5f-a615-21f4b548dd46)
<h1 align="center">🚀 AWS Nginx Reverse Proxy & Load Balancing Demo</h1>

<h3 align="center">
  <img src="https://img.shields.io/badge/Project-DevOps-blue?style=for-the-badge&logo=devops" alt="Project Type">
  <img src="https://img.shields.io/badge/Tech-Nginx-green?style=for-the-badge&logo=nginx" alt="Tech">
  <img src="https://img.shields.io/badge/Status-Demo-yellow?style=for-the-badge" alt="Status">
  <img src="https://img.shields.io/badge/AWS-Cloud-orange?style=for-the-badge&logo=amazon-aws" alt="Cloud">
</h3>

<p align="center">
  <b>A production-style demo showing Nginx reverse proxy, load balancing, rate limiting, and failover on AWS EC2 with private backends.</b>
</p>

---




## Overview 📌

This project demonstrates a production-style Nginx reverse proxy architecture on AWS, where Nginx acts as a single entry point that securely routes traffic to multiple private backend services with load balancing, rate limiting, and failover.

The setup follows best practices by isolating backend services in a private subnet and allowing access only through Nginx.

---
<img width="1721" height="602" alt="Screenshot 2025-12-23 012438" src="https://github.com/user-attachments/assets/2f9c7c08-5d71-4162-b671-a24b605500cd" />

## 🏗️ Architecture Summary
- VPC with public and private subnets
- Nginx EC2 instance in a public subnet
- Two Flask backend servers in a private subnet
- Security Groups to restrict traffic flow
- Rate limiting & connection limiting enforced at Nginx level
- Passive health checks & failover using Nginx upstream configuration
---
## Repo rrchitecture
```bash
nginx-reverse-proxy-project/
├── backend1/ -> ***Backend 1 ***
├── backend2/ -> ***Backend 2 ***
├── ssl/ -> ***Self-signed SSL certificate and key***
├── nginx/ -> ***Nginx configuration***
└── README.md
```
---
## How to Run

1. **Start the backends**
 ssh into the ec2 insteance 
```bash
cd backend/
python3 app.py
```

2. Place SSL certificate and key in the ssl/ folder (or use your own paths).
<img width="1643" height="662" alt="ssl cert" src="https://github.com/user-attachments/assets/e2e8af42-292b-4534-a970-e633606ebad2" />
<img width="1387" height="185" alt="Screenshot 2025-12-14 195213" src="https://github.com/user-attachments/assets/221b0828-066c-4992-8adc-b3503850d83c" />

4. Copy Nginx config and enable site:
```bash
sudo cp nginx/project.conf /etc/nginx/sites-available/nginx_project.conf
sudo ln -s /etc/nginx/sites-available/project.conf /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```
<img width="1648" height="598" alt="Screenshot 2025-12-14 201619" src="https://github.com/user-attachments/assets/0d9a276b-1458-44b0-aa5a-2341d3581586" />

5. Test access:
<img width="1920" height="992" alt="back1result" src="https://github.com/user-attachments/assets/b6b9b305-0214-46af-b6fb-63b171553e43" />
<img width="1920" height="991" alt="back2result" src="https://github.com/user-attachments/assets/b0540861-b509-4c94-a969-123d2f63a8f1" />
### Load Balancing Demonstration
Nginx is configured as a reverse proxy with an upstream backend pool to distribute incoming requests across multiple backend servers.

The following screenshots demonstrate that load balancing is working correctly:
- Each backend server (Backend 1 and Backend 2) is running a Flask application on a different EC2 instance.
- Incoming client requests are forwarded by Nginx to the backends in a round-robin manner.
- The backend logs show successful HTTP `200` responses for requests originating from the Nginx server’s private IP.
- Requests are distributed across both backends, confirming that Nginx is actively balancing the load instead of routing traffic to a single server.

This setup improves availability and scalability by preventing a single backend from becoming a bottleneck.
<img width="1887" height="880" alt="back1load" src="https://github.com/user-attachments/assets/30367f3d-670a-45c2-bf1e-c0320c683302" />
<img width="1907" height="877" alt="back2load" src="https://github.com/user-attachments/assets/fd6ed7c0-41d7-4fab-a58f-7db5b619cabb" />


---
## 🔁 Traffic Flow

1. Client sends HTTP/HTTPS requests from the Internet.
2. Traffic enters the VPC through the Internet Gateway.
3. Requests reach the Nginx Reverse Proxy EC2 in the public subnet.
4. Nginx:
   - Terminates HTTPS
   - Applies rate limiting and connection limiting
   - Forwards requests to backend servers using round-robin load balancing
5. Requests are forwarded to private backend EC2 instances.
6. Backends respond to Nginx, which then returns the response to the client.

## ❤️ Health Checks & Failover

- Nginx performs **passive health checks**.
- If a backend fails to respond:
  - It is temporarily removed from the upstream pool.
  - Traffic is automatically routed to the healthy backend.
- This ensures **high availability** without client-side impact.

## 🚦 Rate Limiting & Connection Limiting

- Implemented at the Nginx layer to protect backend services:
- Rate limiting per client IP
- Connection limiting to prevent abuse and DoS-like behavior
- Helps ensure fair usage and backend stability


## 🔐 Security Design

### Network Isolation
- Backend servers are deployed in a **private subnet**.
- No direct Internet access to backend instances.

### Security Groups

#### Nginx Security Group
- Allows inbound traffic on **ports 80 and 443** from the Internet.

#### Backend Security Group
- Allows inbound traffic **only from the Nginx Security Group**.
- Backend ports:
  - **8081** for Backend 1
  - **8082** for Backend 2


## 🎯 What This Project Demonstrates

- Real-world Nginx reverse proxy usage
- Secure backend isolation in AWS
- Load balancing without managed AWS services
- Rate limiting & traffic control
- High availability using passive health checks
- Production-oriented DevOps architecture
