# Note: `linux/amd64` is a workaround, because elm compiler is not available for `linux/arm64` yet.
# See https://github.com/elm/compiler/issues/2283 for details
# Upd: 0.19.1-6 claims to support arm64, but this Docker build fails.
FROM --platform=linux/amd64 node:20.13-alpine as builder
WORKDIR /app/frontend

# Install dependencies
COPY package.json ./
RUN yarn install

# Copy the project files
COPY . .

# Build the Elm application
RUN yarn build

# Use a lightweight server to serve the built files
FROM nginx:stable-alpine

# Copy the built files to the nginx server
COPY --from=0 /app/frontend/dist /usr/share/nginx/html

# Expose the port for the frontend
EXPOSE 1234

# Start the nginx server
CMD ["nginx", "-g", "daemon off;"]