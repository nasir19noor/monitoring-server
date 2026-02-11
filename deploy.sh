#!/bin/bash

# Server Monitor Deployment Script
# This script helps you deploy the server monitoring tool on your VPS

set -e

echo "==================================="
echo "Server Monitor Deployment Script"
echo "==================================="
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    echo "Visit: https://docs.docker.com/engine/install/"
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    echo "Visit: https://docs.docker.com/compose/install/"
    exit 1
fi

echo "✅ Docker and Docker Compose are installed"
echo ""

# Ask for port configuration
read -p "Enter port to run the monitor on (default: 8080): " PORT
PORT=${PORT:-8080}

# Update docker-compose.yml with the chosen port
if [ "$PORT" != "8080" ]; then
    echo "Updating port configuration to $PORT..."
    sed -i.bak "s/8080:8080/$PORT:8080/g" docker-compose.yml
fi

echo ""
echo "Building and starting the server monitor..."
echo ""

# Build and start with Docker Compose
docker-compose down 2>/dev/null || true
docker-compose build
docker-compose up -d

echo ""
echo "==================================="
echo "✅ Deployment Complete!"
echo "==================================="
echo ""
echo "🌐 Access your monitoring dashboard at:"
echo "   http://$(hostname -I | awk '{print $1}'):$PORT"
echo "   or"
echo "   http://localhost:$PORT"
echo ""
echo "📊 Useful commands:"
echo "   View logs:      docker-compose logs -f"
echo "   Stop monitor:   docker-compose down"
echo "   Restart:        docker-compose restart"
echo "   Status:         docker-compose ps"
echo ""
echo "🔒 Security tip: Consider setting up a reverse proxy with SSL"
echo "    or using SSH tunneling for secure access."
echo ""