# Étape 1 : build Angular
FROM node:22.16.0 AS builder
WORKDIR /app
COPY . .
RUN npm install && npm run build

# Étape 2 : Serve avec nginx
FROM nginx:alpine
COPY --from=builder /app/dist/* /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf

# Spécifie le port explicitement
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
