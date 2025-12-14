# nginx_project
![NGINX-Logo](https://github.com/user-attachments/assets/9d1413ad-74d7-4b5f-a615-21f4b548dd46)

## Overview
This project demonstrates a full Nginx setup as a **reverse proxy** with:
- Load balancing across multiple backends
- Rate limiting and connection limiting
- HTTPS using self-signed certificates
- Proxy caching for optimization

---

nginx-reverse-proxy-project/
├── backend1/ -> ***Backend 1 HTML page***
├── backend2/ -> ***Backend 2 HTML page***
├── ssl/ -> ***Self-signed SSL certificate and key***
├── nginx/ -> ***Nginx configuration***
├── start_backends.sh -> ***Script to run backends***
└── README.md

---
## How to Run

1. **Start the backends**

```bash
./start_backends.sh
```
<img width="1155" height="236" alt="Image" src="https://github.com/user-attachments/assets/175ad3c9-7c3d-400e-ae8d-90a20a41cdfe" />

2. Place SSL certificate and key in the ssl/ folder (or use your own paths).
<img width="1661" height="627" alt="Screenshot 2025-12-14 195137" src="https://github.com/user-attachments/assets/be32ec20-92b6-4175-9bdf-b14acef44330" />
<img width="1387" height="185" alt="Screenshot 2025-12-14 195213" src="https://github.com/user-attachments/assets/221b0828-066c-4992-8adc-b3503850d83c" />

3. Copy Nginx config and enable site:
```bash
sudo cp nginx/nginx.conf /etc/nginx/sites-available/nginx_project.conf
sudo ln -s /etc/nginx/sites-available/nginx_project.conf /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```
<img width="1648" height="598" alt="Screenshot 2025-12-14 201619" src="https://github.com/user-attachments/assets/0d9a276b-1458-44b0-aa5a-2341d3581586" />

4. Test access:
```bash
curl -k https://localhost
```
<img width="1657" height="546" alt="Screenshot 2025-12-14 203229" src="https://github.com/user-attachments/assets/2998ca39-e28e-4b00-b70d-db6d75530e67" />
<img width="961" height="137" alt="Screenshot 2025-12-14 203255" src="https://github.com/user-attachments/assets/1a765986-b797-494a-8986-9aef45e96394" />

---
## Notes
- Ensure ports 8081 and 8082 are free for the backends.
- curl -k ignores SSL warnings (for self-signed certificates).
- Rate limiting and connection limiting help protect backends from overload.
- Proxy caching improves performance by storing frequently accessed responses.


