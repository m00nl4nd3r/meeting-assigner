#!/bin/bash

# Meeting Assigner - Deployment Script
# https://github.com/m00nl4nd3r/meeting-assigner

set -e

echo "=================================="
echo "Meeting Assigner v3.5.0"
echo "=================================="
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Error: Docker is not installed."
    echo "Please install Docker first: https://docs.docker.com/get-docker/"
    exit 1
fi
echo "✓ Docker is installed"

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Error: Docker is not running."
    echo "Please start Docker and try again."
    exit 1
fi
echo "✓ Docker is running"

# Detect Docker Compose command
if docker compose version &> /dev/null 2>&1; then
    COMPOSE_CMD="docker compose"
    echo "✓ Docker Compose (plugin) detected"
elif command -v docker-compose &> /dev/null; then
    COMPOSE_CMD="docker-compose"
    echo "✓ Docker Compose (standalone) detected"
else
    COMPOSE_CMD=""
    echo "⚠ Docker Compose not found, using plain Docker"
fi

echo ""
echo "Deploying..."
echo ""

if [ -n "$COMPOSE_CMD" ]; then
    # Docker Compose deployment
    $COMPOSE_CMD down 2>/dev/null || true
    $COMPOSE_CMD build --no-cache
    $COMPOSE_CMD up -d
    
    CONTAINER_NAME="meeting-assigner"
    LOG_CMD="$COMPOSE_CMD logs -f"
    STOP_CMD="$COMPOSE_CMD down"
else
    # Plain Docker deployment
    docker stop meeting-assigner 2>/dev/null || true
    docker rm meeting-assigner 2>/dev/null || true
    docker build --no-cache -t meeting-assigner .
    docker run -d -p 80:80 --name meeting-assigner --restart unless-stopped meeting-assigner
    
    CONTAINER_NAME="meeting-assigner"
    LOG_CMD="docker logs -f meeting-assigner"
    STOP_CMD="docker stop meeting-assigner && docker rm meeting-assigner"
fi

# Wait for container to be ready
echo ""
echo "Waiting for container..."
sleep 3

# Verify deployment
if docker ps | grep -q "$CONTAINER_NAME"; then
    echo ""
    echo "=================================="
    echo "✓ Deployment Successful!"
    echo "=================================="
    echo ""
    echo "Access the application at:"
    echo "  → http://localhost"
    echo ""
    echo "Container status:"
    docker ps --filter name="$CONTAINER_NAME" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
    echo ""
    echo "Useful commands:"
    echo "  → View logs: $LOG_CMD"
    echo "  → Stop: $STOP_CMD"
    echo ""
else
    echo ""
    echo "❌ Deployment may have failed"
    echo "Checking logs..."
    docker logs "$CONTAINER_NAME" 2>&1 | tail -20
    exit 1
fi
