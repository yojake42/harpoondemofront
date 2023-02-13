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
# COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./nginx.conf.template /etc/nginx/conf.d/default.conf.template

# COPY ./nginx.conf.template /etc/nginx/conf.d/default.conf
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]