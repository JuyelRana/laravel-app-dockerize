FROM nginx:latest

WORKDIR /var/www/html

# Copy custom nginx configuration to run the application
COPY server/config/server.conf /etc/nginx/conf.d/default.conf

EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
