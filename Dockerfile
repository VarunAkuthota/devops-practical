# Stage 1: Install dependencies
FROM node:14 AS build
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install

# Stage 2: Copy files and run the application
FROM node:14
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY . .
EXPOSE 3000
CMD ["npm", "start"]