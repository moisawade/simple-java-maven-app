
FROM bitnami/nginx
#FROM nginx:stable-alpine
ADD index.html /app/
EXPOSE 8080
EXPOSE 8443
