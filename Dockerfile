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
COPY wait-for-it.sh /usr/src/app/wait-for-it.sh
RUN chmod +x /usr/src/app/wait-for-it.sh
EXPOSE 3000
CMD ["./wait-for-it.sh", "mongo:27017", "--", "npm", "start"]