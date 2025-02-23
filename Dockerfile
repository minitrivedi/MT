# Use the official Nginx image from the Docker Hub
FROM nginx:latest

# Copy your custom nginx configuration file to the container (optional)
# COPY nginx.conf /etc/nginx/nginx.conf

# Copy your website or content to the default nginx directory
#COPY ./html /usr/share/nginx/html

# Expose port 80 to be able to access Nginx from outside the container
EXPOSE 80

# Start Nginx in the foreground (this is the default command in the official Nginx image)
CMD ["nginx", "-g", "daemon off;"]
