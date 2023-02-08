FROM node:16.13 as compiler

# Set the working directory to /app
WORKDIR /app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install 

# Copy the current directory contents into the container at /app
COPY . .

EXPOSE 80
CMD [ "npm", "start" ]