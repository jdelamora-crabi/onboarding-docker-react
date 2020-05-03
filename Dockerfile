# Production environment dockerfile

# Build image for node project building.
FROM node:alpine AS builder
WORKDIR /usr/app
COPY package.json ./
RUN npm install
COPY ./ ./
RUN npm run build

# final image, only build files from build image.
FROM nginx
EXPOSE 80
COPY --from=builder /usr/app/build /usr/share/nginx/html