# syntax=docker/dockerfile:1

# specify a base image
FROM node:14.17.1 AS base
# specify a workdir
WORKDIR /app
# copy package.json and package-lock.json
COPY package.json package.json
COPY package-lock.json package-lock.json


# specify a test build stage
FROM base AS test
# install dependencies
RUN npm ci
# copy over the rest of the files
COPY . .
# run command
CMD ["npm", "run", "test"]


# specify a production build stage
FROM base AS prod
# install non-dev dependencies
RUN npm ci --production
# copy over the rest of the files
COPY . .
# expose container port to host
EXPOSE 3000
# run command
CMD ["npm", "start"]


###### TERMINAL COMMANDS ######
## build the image
# docker build .

## print images
# docker images

## run the image
# docker run -p <host-port>:<docker-port> <image-id>

## build and give the image a name
# docker build . -t <image-name>

## run the image name instead of id
# docker run -p <host-port>:<docker-port> <image-name>

## build specific target
# docker build . -t <image-name> --target <test>
# docker build . -t <image-name> --target <prod>
