#!/usr/bin/env bash
set -euo pipefail

IMAGE="cst-meeting-assigner"
CONTAINER="cst-assigner"
PORT="${1:-8080}"

echo ""
echo "  ╔══════════════════════════════════════╗"
echo "  ║   CST Meeting Assigner — Deploy      ║"
echo "  ║   v5.1.0                              ║"
echo "  ╚══════════════════════════════════════╝"
echo ""

# Build image
echo "→ Building Docker image..."
docker build -t "$IMAGE" .

# Stop & remove existing container if running
if docker ps -aq --filter "name=$CONTAINER" | grep -q .; then
  echo "→ Stopping existing container..."
  docker stop "$CONTAINER" 2>/dev/null || true
  docker rm "$CONTAINER" 2>/dev/null || true
fi

# Run
echo "→ Starting container on port $PORT..."
docker run -d \
  --name "$CONTAINER" \
  -p "$PORT:80" \
  --restart unless-stopped \
  "$IMAGE"

echo ""
echo "  ✅  Running at http://localhost:$PORT"
echo "  📋  Logs:   docker logs -f $CONTAINER"
echo "  🛑  Stop:   docker stop $CONTAINER"
echo ""
