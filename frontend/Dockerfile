# Étape 1 : Compilation Node.js
FROM node:alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --configuration=production

# Étape 2 : Serveur Nginx
FROM nginx:alpine
# Suppression de la config par défaut et injection de la nôtre
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copie des fichiers compilés 
COPY --from=build /app/dist/task-manager-front/browser /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
