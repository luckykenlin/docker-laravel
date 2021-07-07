# ================================
# Compile all assets
FROM node:14 AS builder
WORKDIR /srv

COPY ./resources ./resources
COPY ["./package.json", "./webpack.mix.js", "/srv/"]

RUN npm install
RUN npm run production

# ================================
# Prepare the final image
FROM bitnami/nginx:1.19
COPY ./public /app/public
COPY --from=builder /srv/public/ /app/public/
