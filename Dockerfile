FROM oven/bun:1.4.2-alpine AS dev
WORKDIR /app
COPY package.json bun.lock ./
RUN bun install --frozen-lockfile
COPY --chown=bun:bun . .
USER bun
EXPOSE 3000
CMD ["bun", "--watch", "src/index.ts"]

FROM oven/bun:1.4.2-alpine AS prod
WORKDIR /app
ENV NODE_ENV=production
COPY package.json bun.lock ./
RUN bun install --frozen-lockfile --production
COPY tsconfig.json ./
COPY src ./src
USER bun
EXPOSE 3000
CMD ["bun", "src/index.ts"]
