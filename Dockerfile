
#FROM bitnami/nginx
FROM nginx
ADD index.html /app/
EXPOSE 8080
EXPOSE 8443