FROM node:20-slim
# git is needed by Baileys' libsignal dependency; ffmpeg for stickers/audio; yt-dlp for .play/.ytmp4
RUN apt-get update && apt-get install -y --no-install-recommends git ffmpeg python3 curl ca-certificates \
 && curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp \
 && chmod a+rx /usr/local/bin/yt-dlp \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY package.json ./
RUN npm install --omit=dev
COPY . .
ENV NODE_ENV=production
CMD ["node", "index.js"]
