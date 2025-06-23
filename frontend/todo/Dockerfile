# Build stage
FROM node:18-alpine AS build

WORKDIR /todo
COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Production stage
FROM nginx:stable-alpine

COPY --from=build /todo/build /usr/share/nginx/html

# Optional: copy custom nginx config for SPA fallback if needed
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
