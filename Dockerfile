FROM node:slim

WORKDIR /trss

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

RUN apt update && apt install -y \
    chromium \
    git \
    ffmpeg \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*
    && apt clean

COPY package.json pnpm-lock.yaml ./

RUN pnpm install -P

COPY . .

EXPOSE 2536

CMD ["sh", "-c", "pnpm install -P && node app"]