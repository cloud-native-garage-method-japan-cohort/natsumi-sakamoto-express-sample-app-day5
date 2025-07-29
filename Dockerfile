# Use node Docker image, version 16-alpine
#FROM node:22
#FROM node:18-slim
FROM docker.io/guergeiro/pnpm:20-10-slim

# From the documentation, "The WORKDIR instruction sets the working directory for any
# RUN, CMD, ENTRYPOINT, COPY and ADD instructions that follow it in the Dockerfile"
WORKDIR /usr/src/app

#追記
RUN mkdir /usr/src/app/.npm && chown -R 1000830001:1000830001 /usr/src/app/.npm

# COPY package.json and package-lock.json into root of WORKDIR
COPY package*.json ./

#ENV npm_config_cache=/tmp/.npm

# Executes commands
#RUN npm ci
#RUN mkdir /.npm && chown -R 1000830001:1000830001 /.npm && npm ci
USER 1000830001
RUN npm ci

# Copies files from source to destination, in this case the root of the build context
# into the root of the WORKDIR
COPY . .

# Document that this container exposes something on port 3000
EXPOSE 3000

# Command to use for starting the application
CMD ["npm", "start"]
