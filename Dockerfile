FROM node:14-alpine

# Required if accessing packages on git via npm
RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

# To handle 'not get uid/gid'
RUN npm config set unsafe-perm true

RUN npm install -g npm@latest

RUN apk add yarn

WORKDIR /app

COPY ./app/package*.json ./

RUN yarn install

COPY ./app ./

RUN ["yarn", "build"]

EXPOSE 8080

ENTRYPOINT ["yarn", "serve"]

