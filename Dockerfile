ARG NODE_VERSION=24.1.0

FROM node:${NODE_VERSION} AS build
WORKDIR /build-stage

COPY node-hello/ ./

#add production env to exclude dev dependencies
ENV NODE_ENV=production

RUN npm ci

FROM node:${NODE_VERSION}-bookworm-slim AS runtime
# Create app directory
WORKDIR /usr/src/app

USER node

COPY --chown=node:node --from=build /build-stage/ /usr/src/app


CMD [ "node", "index.js" ]