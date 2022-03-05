# Production file
# Make an image that runs the application specifically in production

# Build phase
# install dependencies and build our application (create a compact folder with only what we need)
# will result in a build directory
FROM node:16-alpine as builder

WORKDIR '/app'

COPY ./package.json ./

RUN npm install

COPY . .

# will result in a build folder inside the app directory
RUN npm run build


# Run phase
# https://hub.docker.com/_/nginx
FROM nginx

EXPOSE 3000

# Copy nginx ocnfiguration file and replace existing file
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
# Copy build folder from other phase called builder to /user/share/nginx/html
COPY --from=builder /app/build /usr/share/nginx/html

# we don't need to set up a command, because the default command of the container starts nginx