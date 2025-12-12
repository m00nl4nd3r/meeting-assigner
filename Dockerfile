# Meeting Assigner - Docker Image
# Lightweight nginx container serving a single HTML file

FROM nginx:alpine

LABEL maintainer="m00nl4nd3r"
LABEL version="3.5.0"
LABEL description="Weekly meeting role assignment tool"

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy the application
COPY meeting_assigner.html /usr/share/nginx/html/index.html

# Fix permissions - nginx runs as user 'nginx' (UID 101)
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html && \
    chmod 644 /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost/ || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
