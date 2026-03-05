FROM nginx:alpine

LABEL maintainer="CST Team"
LABEL version="5.2.0"
LABEL description="CST Meeting Assigner — Weekly role assignment tool for Concierge Security Teams"

# Copy the single-file app as the default page
COPY meeting_assigner.html /usr/share/nginx/html/index.html

# Healthcheck
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost/ || exit 1

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
