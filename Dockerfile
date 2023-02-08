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

EXPOSE 3000
CMD [ "npm", "start" ]