FROM node:16.13 as compiler

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
# COPY package*.json ./

RUN npm install 
RUN npm install bootstrap
RUN npm install react-router-dom



RUN npm run build

FROM nginx
COPY --from=compiler /app/build/ /usr/share/nginx/html
COPY ./default.conf.template /etc/nginx/templates/default.conf.template
# COPY ./nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx-debug", "-g", "daemon off;"]