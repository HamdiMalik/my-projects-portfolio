#!/bin/bash

echo "🚀 Starting Skin Check API Deployment on WSL Ubuntu..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Stop and remove existing containers
echo "🛑 Stopping existing containers..."
docker-compose down

# Remove existing images to ensure fresh build
echo "🧹 Cleaning up existing images..."
docker rmi skincheck-backend 2>/dev/null || true

# Build the Docker image
echo "🔨 Building Docker image..."
docker-compose build --no-cache

# Start the services
echo "🚀 Starting services..."
docker-compose up -d

# Wait for services to be ready
echo "⏳ Waiting for services to be ready..."
sleep 10

# Check if services are running
echo "🔍 Checking service status..."
docker-compose ps

# Test the API
echo "🧪 Testing API endpoint..."
sleep 5
curl -f http://localhost:5000/api/v1/health || echo "❌ API health check failed"

echo "✅ Deployment completed!"
echo "📱 API is running at: http://localhost:5000"
echo "🔍 Health check: http://localhost:5000/api/v1/health"
echo "📊 Scan endpoint: http://localhost:5000/api/v1/scan"
echo ""
echo "📋 Useful commands:"
echo "  - View logs: docker-compose logs -f"
echo "  - Stop services: docker-compose down"
echo "  - Restart services: docker-compose restart" 