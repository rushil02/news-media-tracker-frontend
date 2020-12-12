FROM node:14-alpine

# Required if accessing packages on git via npm
RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

# To handle 'not get uid/gid'
RUN npm config set unsafe-perm true

RUN npm install -g npm@latest

WORKDIR /app

COPY ./app/package*.json ./

RUN npm ci

COPY ./bin/cronjobs /etc/crontabs/root

RUN ["chmod", "+x", "./bin/entrypoint.sh", "./bin/frontend_builder.sh"]

ENTRYPOINT [ "./bin/entrypoint.sh" ]
