FROM node:20-slim

RUN apt-get update && apt-get install -y --no-install-recommends git ffmpeg python3 curl ca-certificates unzip \
 && curl -fsSL https://deno.land/install.sh | DENO_INSTALL=/opt/deno sh -s -- -y --no-modify-path \
 && ln -s /opt/deno/bin/deno /usr/local/bin/deno \
 && deno --version \
 && curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp \
 && chmod a+rx /usr/local/bin/yt-dlp \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

ENV PORT=10000
EXPOSE 10000

CMD ["node", "index.js"]
