FROM node:16.13 as compiler

# Set the working directory to /app
WORKDIR /app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install 
RUN npm install bootstrap
RUN npm install react-router-dom

# Copy the current directory contents into the container at /app
COPY . .

RUN npm run build

FROM nginx:alpine
COPY --from=compiler /app/build/ /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
ENV back_end_url http://srv-63e57896d6634700175dd5cb-internal.harpoon-78739-26567.svc.cluster.local:5000/
# COPY ./nginx.conf.template /etc/nginx/
EXPOSE 80

# CMD ["/bin/bash", "-c", "envsubst < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf && exec nginx -g 'daemon off;'"]

# FROM openresty/openresty

# COPY --from=compiler /app/build/ /usr/share/nginx/html

# COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# EXPOSE 80

# CMD [ "nginx", "-c", "/etc/nginx/conf.d/default.conf", "-g", "daemon off;" ]
