FROM nginx:alpine
LABEL version="5.0.0"
LABEL description="CST Meeting Assigner — Weekly role assignment tool"
COPY meeting_assigner.html /usr/share/nginx/html/index.html
EXPOSE 80
