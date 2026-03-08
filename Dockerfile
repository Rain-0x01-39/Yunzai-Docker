FROM node:trixie-slim

WORKDIR /trss

RUN npm install -g pnpm

RUN apt update && apt install -y --no-install-recommends \
    chromium \
    git \
    ffmpeg \
    ca-certificates \
    fastfetch \
    && rm -rf /var/lib/apt/lists/* \
    && apt clean

RUN mkdir -p data temp

# RUN pnpm install -P

COPY . .

EXPOSE 2536

CMD ["/bin/sh", "-c", "pnpm install -P --prefer-offline && exec node app"]
