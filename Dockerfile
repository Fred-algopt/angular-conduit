FROM node:22.16.0 AS builder
WORKDIR /app
COPY . .
RUN npm ci
RUN npm run build -- --configuration production

FROM nginx:alpine
COPY --from=builder /app/dist/angular-realworld /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
