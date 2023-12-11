FROM node:18-alpine AS base

FROM base AS deps
RUN apk add --no-cache libc6-compat
WORKDIR /app
COPY .yarn .yarn
COPY .yarnrc.yml package.json yarn.lock ./
COPY .contentlayer /
RUN yarn add esbuild && yarn


FROM base AS builder
WORKDIR /app
COPY --from=deps /app/.yarn ./.yarn
COPY --from=deps /app/node_modules ./node_modules
COPY --from=deps /app/.pnp.* ./
COPY --from=deps /app/.yarnrc.yml /app/package.json /app/yarn.lock ./
COPY . .
RUN yarn build

FROM base AS runner
ENV NODE_ENV production
WORKDIR /app
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

EXPOSE 3005
ENV PORT 3005
ENV HOSTNAME "0.0.0.0"

CMD ["node", "server.js"]