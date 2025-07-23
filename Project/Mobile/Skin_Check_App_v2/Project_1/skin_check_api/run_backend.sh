#!/bin/bash

echo "🚀 Building and Running Skin Check Backend..."

# Build the Docker image
echo "🔨 Building Docker image..."
docker build -t skincheck-backend .

# Stop existing container if running
echo "🛑 Stopping existing container..."
docker stop skincheck-backend 2>/dev/null || true
docker rm skincheck-backend 2>/dev/null || true

# Run the container
echo "🚀 Starting backend container..."
docker run -d \
  --name skincheck-backend \
  -p 5000:5000 \
  -v $(pwd)/uploads:/app/uploads \
  -v $(pwd)/models:/app/models \
  skincheck-backend

echo "✅ Backend is running!"
echo "📱 API URL: http://localhost:5000"
echo "🔍 Health check: http://localhost:5000/api/v1/health"
echo "📊 Scan endpoint: http://localhost:5000/api/v1/scan"
echo ""
echo "📋 Useful commands:"
echo "  - View logs: docker logs -f skincheck-backend"
echo "  - Stop: docker stop skincheck-backend"
echo "  - Restart: docker restart skincheck-backend" 