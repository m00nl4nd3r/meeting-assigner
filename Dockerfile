FROM nginx:alpine

LABEL maintainer="m00nl4nd3r"
LABEL description="CST Meeting Assigner — balanced weekly meeting role assignments"
LABEL version="4.5.0"

# Remove default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy the single-file application
COPY meeting_assigner.html /usr/share/nginx/html/index.html

# Custom nginx config for SPA + caching
RUN cat > /etc/nginx/conf.d/default.conf << 'EOF'
server {
    listen 80;
    server_name _;
    root /usr/share/nginx/html;
    index index.html;

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;

    # Cache the HTML for 1 hour (it's a single file app)
    location / {
        try_files $uri $uri/ /index.html;
        expires 1h;
        add_header Cache-Control "public, no-transform";
    }

    # Health check endpoint
    location /health {
        access_log off;
        return 200 "ok";
        add_header Content-Type text/plain;
    }
}
EOF

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget -qO- http://localhost/health || exit 1
