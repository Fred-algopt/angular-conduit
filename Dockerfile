# Étape 1 : build Angular
FROM node:20.11.1 AS build

WORKDIR /app
COPY . .

# Installation avec contournement des conflits de dépendances
RUN npm install --legacy-peer-deps

# Construction du projet Angular
RUN npm run build --prod

# Étape 2 : image de production
FROM nginx:alpine

# Copie du build Angular dans NGINX
COPY --from=build /app/dist/ /usr/share/nginx/html
