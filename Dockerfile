FROM node:22.16.0 AS builder
WORKDIR /app
COPY . .
RUN npm ci
RUN npm run build -- --configuration production

FROM nginx:alpine
COPY --from=builder /app/dist/angular-conduit /usr/share/nginx/html
RUN sed -i 's/listen       80;/listen       8080;/' /etc/nginx/conf.d/default.conf
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
