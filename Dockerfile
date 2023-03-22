FROM node:lts-alpine

ARG REPO_MAINTAINER="adams549659584"
ARG REPO_BRANCH="develop"
ARG REPO_STATIC_BRANCH=${REPO_BRANCH}-static
ARG REPO_URL=https://github.com/${REPO_MAINTAINER}/chatgpt-web.git

RUN npm install pnpm -g

WORKDIR /app

COPY /service/package.json /app

COPY /service/pnpm-lock.yaml /app

RUN pnpm install --production && rm -rf /root/.npm /root/.pnpm-store /usr/local/share/.cache /tmp/*

RUN git clone -b ${REPO_STATIC_BRANCH} ${REPO_URL} /static \
    && cp -rf /static/* /app \
    && rm -rf /static

EXPOSE 3002

CMD ["pnpm", "run", "prod"]
