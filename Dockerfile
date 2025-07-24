# Étape 1 : builder Angular
FROM node:22.16.0 AS builder
WORKDIR /app
COPY . .
RUN npm install && npm run build

# Étape 2 : servir avec nginx
FROM nginx:alpine
COPY --from=builder /app/dist/angular-material-site /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
