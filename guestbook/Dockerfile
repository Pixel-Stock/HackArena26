FROM nginx:1.27-alpine

# Replace the default Nginx landing page with the Guestbook application.
COPY app/index.html /usr/share/nginx/html/index.html

# Nginx listens on port 80 inside the container.
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
