FROM nginx:alpine

LABEL maintainer="m00nl4nd3r"
LABEL version="4.0.0"
LABEL description="CST Meeting Assigner - Fair meeting role assignment for Concierge Security Teams"

RUN rm -rf /usr/share/nginx/html/*

COPY meeting_assigner.html /usr/share/nginx/html/index.html

RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html && \
    chmod 644 /usr/share/nginx/html/index.html

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
