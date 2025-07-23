# SkinCheck Full-Stack Application Setup Guide

This guide will help you set up and run the complete SkinCheck application using Docker.

## 📋 Prerequisites

Before you begin, make sure you have the following installed on your system:

- **Docker**: [Install Docker](https://docs.docker.com/get-docker/)
- **Docker Compose**: [Install Docker Compose](https://docs.docker.com/compose/install/)
- **Git**: [Install Git](https://git-scm.com/downloads)

## 🏗️ Project Structure

```
skincheck-app/
├── frontend/                 # React + TypeScript frontend
│   ├── src/
│   ├── Dockerfile
│   ├── nginx.conf
│   └── package.json
├── backend/                  # Flask + SQLAlchemy backend
│   ├── app/
│   ├── config.py
│   ├── run.py
│   ├── Dockerfile
│   └── requirements.txt
├── database/
│   └── init.sql             # Database initialization
├── steps/
│   └── setup_instructions.md # This file
└── docker-compose.yml       # Docker orchestration
```

## 🚀 Quick Start (Docker Compose)

### 1. Clone the Repository

```bash
git clone <repository-url>
cd skincheck-app
```

### 2. Set Up Environment Variables

#### Backend Environment (.env)
Create `backend/.env`:

```env
# Database Configuration
DB_HOST=mysql_db
DB_PORT=3306
DB_NAME=skincheck_db
DB_USER=skincheck_user
DB_PASSWORD=skincheck_password123

# Flask Configuration
FLASK_ENV=production
SECRET_KEY=your-super-secret-key-here-change-this
JWT_SECRET_KEY=your-jwt-secret-key-here-change-this

# Upload Configuration
UPLOAD_FOLDER=uploads
MAX_CONTENT_LENGTH=16777216

# CORS Configuration
FRONTEND_URL=http://localhost:3000
```

#### Frontend Environment (.env)
Create `frontend/.env`:

```env
VITE_API_BASE_URL=http://localhost:5000/api
```

### 3. Run the Complete Application

```bash
# Build and start all services
docker-compose up --build

# Or run in detached mode
docker-compose up --build -d
```

### 4. Access the Application

- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:5000/api
- **Health Check**: http://localhost:5000/api/health
- **MySQL Database**: localhost:3306

### 5. Initialize Database (First Time Only)

The database will be automatically initialized with the schema and sample data when the MySQL container starts for the first time.

To manually reinitialize:

```bash
# Connect to backend container
docker exec -it skincheck_backend bash

# Initialize database
flask init-db

# Seed with sample data (optional)
flask seed-db
```

## 🔧 Manual Setup (Without Docker Compose)

### Database Setup

1. **Run MySQL Container**:
```bash
docker run -d \
  --name skincheck_mysql \
  -e MYSQL_ROOT_PASSWORD=rootpassword123 \
  -e MYSQL_DATABASE=skincheck_db \
  -e MYSQL_USER=skincheck_user \
  -e MYSQL_PASSWORD=skincheck_password123 \
  -p 3306:3306 \
  mysql:8.0
```

2. **Initialize Database**:
```bash
# Copy init script to container
docker cp database/init.sql skincheck_mysql:/tmp/

# Execute initialization
docker exec -i skincheck_mysql mysql -u root -prootpassword123 < /tmp/init.sql
```

### Backend Setup

1. **Build Backend Image**:
```bash
cd backend
docker build -t skincheck-backend .
```

2. **Run Backend Container**:
```bash
docker run -d \
  --name skincheck_backend \
  --link skincheck_mysql:mysql_db \
  -p 5000:5000 \
  --env-file .env \
  -v $(pwd)/uploads:/app/uploads \
  skincheck-backend
```

### Frontend Setup

1. **Build Frontend Image**:
```bash
cd frontend
docker build -t skincheck-frontend .
```

2. **Run Frontend Container**:
```bash
docker run -d \
  --name skincheck_frontend \
  -p 3000:80 \
  --link skincheck_backend:backend \
  skincheck-frontend
```

## 🧪 Testing the Integration

### 1. Health Check

```bash
# Check backend health
curl http://localhost:5000/api/health

# Expected response:
# {"status": "healthy", "message": "SkinCheck API is running"}
```

### 2. Test User Registration

```bash
curl -X POST http://localhost:5000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "fullName": "Test User",
    "email": "test@example.com",
    "password": "TestPassword123",
    "confirmPassword": "TestPassword123"
  }'
```

### 3. Test User Login

```bash
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "TestPassword123"
  }'
```

### 4. Test Protected Endpoint

```bash
# Use the access_token from login response
curl -X GET http://localhost:5000/api/users/profile \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

## 🔒 Security Configuration

### Environment Variables Security

⚠️ **Important**: Change all default passwords and secrets in production!

```env
# Use strong, unique values for production
SECRET_KEY=generate-a-strong-secret-key-here
JWT_SECRET_KEY=generate-a-strong-jwt-secret-here
MYSQL_ROOT_PASSWORD=use-a-strong-root-password
DB_PASSWORD=use-a-strong-database-password
```

### CORS Configuration

The backend is configured to accept requests from the frontend URL specified in `FRONTEND_URL`. Adjust this for your deployment environment.

### SSL/HTTPS

For production deployment:

1. **Frontend**: Configure nginx with SSL certificates
2. **Backend**: Use a reverse proxy (nginx/traefik) with SSL termination
3. **Database**: Use SSL connections for database access

## 📊 Monitoring and Logs

### View Container Logs

```bash
# All services
docker-compose logs

# Specific service
docker-compose logs backend
docker-compose logs frontend
docker-compose logs mysql_db

# Follow logs in real-time
docker-compose logs -f backend
```

### Container Health Status

```bash
# Check all containers
docker-compose ps

# Check specific container
docker inspect skincheck_backend --format='{{.State.Health.Status}}'
```

### Database Monitoring

```bash
# Connect to MySQL
docker exec -it skincheck_mysql mysql -u skincheck_user -p skincheck_db

# Show tables
SHOW TABLES;

# Check user count
SELECT COUNT(*) FROM users;

# Check recent scans
SELECT * FROM scans ORDER BY created_at DESC LIMIT 5;
```

## 🛠️ Development Mode

### Hot Reload Setup

For development with hot reload:

1. **Backend Development**:
```bash
cd backend
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r requirements.txt
export FLASK_ENV=development
python run.py
```

2. **Frontend Development**:
```bash
cd frontend
npm install
npm run dev
```

### Debug Mode

Enable debug logging in backend:

```env
FLASK_ENV=development
FLASK_DEBUG=1
```

## 🚀 Production Deployment

### Security Checklist

- [ ] Change all default passwords
- [ ] Use environment-specific secrets
- [ ] Enable HTTPS/SSL
- [ ] Configure proper CORS origins
- [ ] Set up database backups
- [ ] Configure log monitoring
- [ ] Use non-root database users
- [ ] Implement rate limiting
- [ ] Set up container health checks

### Scaling Considerations

1. **Database**: Use managed MySQL service (AWS RDS, Google Cloud SQL)
2. **File Storage**: Use object storage (AWS S3, Google Cloud Storage)
3. **Load Balancer**: Use nginx or cloud load balancer
4. **Container Orchestration**: Consider Kubernetes for large deployments

## ❌ Troubleshooting

### Common Issues

1. **Database Connection Failed**:
   - Check if MySQL container is running
   - Verify database credentials
   - Ensure network connectivity between containers

2. **Frontend Can't Connect to Backend**:
   - Check `VITE_API_BASE_URL` environment variable
   - Verify backend is accessible
   - Check CORS configuration

3. **Permission Denied Errors**:
   - Check file permissions for uploads directory
   - Ensure Docker has access to bind mount paths

4. **Port Already in Use**:
   - Change port mappings in docker-compose.yml
   - Kill processes using the ports: `sudo lsof -i :3000`

### Debug Commands

```bash
# Check container status
docker-compose ps

# View container logs
docker-compose logs [service_name]

# Execute commands in containers
docker exec -it skincheck_backend bash
docker exec -it skincheck_mysql mysql -u root -p

# Restart specific service
docker-compose restart backend

# Rebuild specific service
docker-compose up --build backend
```

### Network Issues

```bash
# Test connectivity between containers
docker exec skincheck_backend ping mysql_db
docker exec skincheck_frontend curl http://backend:5000/api/health

# Check Docker networks
docker network ls
docker network inspect skincheck_skincheck_network
```

## 📁 Data Persistence

### Database Data

Database data is persisted in Docker volume `mysql_data`. To backup:

```bash
# Backup database
docker exec skincheck_mysql mysqldump -u root -prootpassword123 skincheck_db > backup.sql

# Restore database
docker exec -i skincheck_mysql mysql -u root -prootpassword123 skincheck_db < backup.sql
```

### Uploaded Files

Uploaded scan images are stored in `backend/uploads/` and mounted as a Docker volume.

## 🔄 Updates and Maintenance

### Update Application

```bash
# Pull latest changes
git pull origin main

# Rebuild and restart
docker-compose down
docker-compose up --build
```

### Database Migrations

```bash
# Access backend container
docker exec -it skincheck_backend bash

# Run migrations (if using Flask-Migrate)
flask db upgrade
```

## 📞 Support

For issues or questions:

1. Check the logs: `docker-compose logs`
2. Review this setup guide
3. Check Docker and container status
4. Verify environment variables
5. Test API endpoints manually

---

**🎉 Congratulations!** Your SkinCheck application should now be running successfully. Visit http://localhost:3000 to start using the application.