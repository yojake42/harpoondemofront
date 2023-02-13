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

FROM nginx
COPY --from=compiler /app/build/ /usr/share/nginx/html
ENV back_end_url=http://srv-63e57896d6634700175dd5cb-internal.harpoon-78739-26567.svc.cluster.local:5000/
# COPY ./default.conf.template /etc/nginx/templates
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
