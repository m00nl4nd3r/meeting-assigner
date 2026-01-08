#!/bin/bash
set -e

echo "=================================="
echo "CST Meeting Assigner v4.0.0"
echo "=================================="

if ! command -v docker &> /dev/null; then
    echo "❌ Docker not installed. Get it at https://docs.docker.com/get-docker/"
    exit 1
fi

if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker not running. Start Docker and try again."
    exit 1
fi

echo "✓ Docker ready"

if docker compose version &> /dev/null 2>&1; then
    COMPOSE="docker compose"
elif command -v docker-compose &> /dev/null; then
    COMPOSE="docker-compose"
else
    COMPOSE=""
fi

echo "Deploying..."

if [ -n "$COMPOSE" ]; then
    $COMPOSE down 2>/dev/null || true
    $COMPOSE build --no-cache
    $COMPOSE up -d
    CONTAINER="cst-meeting-assigner"
else
    docker stop cst-meeting-assigner 2>/dev/null || true
    docker rm cst-meeting-assigner 2>/dev/null || true
    docker build --no-cache -t cst-meeting-assigner .
    docker run -d -p 80:80 --name cst-meeting-assigner --restart unless-stopped cst-meeting-assigner
    CONTAINER="cst-meeting-assigner"
fi

sleep 3

if docker ps | grep -q "$CONTAINER"; then
    echo ""
    echo "=================================="
    echo "✓ Success!"
    echo "=================================="
    echo ""
    echo "Open: http://localhost"
    echo ""
    docker ps --filter name="$CONTAINER" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
else
    echo "❌ Failed. Check: docker logs $CONTAINER"
    exit 1
fi
