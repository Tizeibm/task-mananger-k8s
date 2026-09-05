# Étape 1 : Compilation (Builder)
FROM node:alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
# Compile en utilisant environment.prod.ts
RUN npm run build --configuration=production 

# Étape 2 : Production avec ton image locale Nginx
FROM nginx:latest
# Copie les fichiers statiques compilés depuis l'étape 1
COPY --from=builder /app/dist/task-manager-front/browser /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
