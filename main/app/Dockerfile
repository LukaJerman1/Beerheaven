# pull the base image
FROM node:14.16.1-alpine

# set the working direction
WORKDIR /app

# add '/app/node_modules/.bin' to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# install app dependencies
COPY ./package.json ./

COPY ./package-lock.json ./

RUN npm install --silent  

# add app
COPY . ./

EXPOSE 8000

# start app
CMD ["npm", "start"]