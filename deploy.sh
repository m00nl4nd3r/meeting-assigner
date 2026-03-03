#!/bin/bash
set -e

echo "🚀 CST Meeting Assigner — Deploy"
echo "================================="

# Build
echo "Building Docker image..."
docker build -t cst-meeting-assigner .

# Stop existing container if running
if docker ps -q --filter "name=cst-assigner" | grep -q .; then
  echo "Stopping existing container..."
  docker stop cst-assigner
  docker rm cst-assigner
fi

# Run
echo "Starting container on port 8080..."
docker run -d --name cst-assigner -p 8080:80 --restart unless-stopped cst-meeting-assigner

echo ""
echo "✅ Running at http://localhost:8080"
