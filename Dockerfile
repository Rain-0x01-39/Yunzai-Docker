FROM node:trixie-slim
LABEL org.opencontainers.image.source=https://github.com/Rain-0x01-39/Yunzai-Docker
LABEL org.opencontainers.image.description="不要啊Docker"
LABEL org.opencontainers.image.licenses=MIT

WORKDIR /trss

RUN npm install -g pnpm

RUN apt update && apt install -y --no-install-recommends \
    rsync \
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

RUN mkdir -p /defaults/config /defaults/plugins && \
    cp -r /trss/config/* /defaults/config/ \
    cp -r /trss/plugins/* /defaults/plugins/

EXPOSE 2536

# CMD ["/bin/sh", "-c", "pnpm install -P --prefer-offline && exec node app"]
ENTRYPOINT [ "./entrypoint.sh" ]