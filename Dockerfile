# this is reactjs app for production ready build with nginx server 
# builder is used stage phase for the node server container
FROM node:alpine as builder 
WORKDIR '/app'
COPY package.json .
RUN npm install 
COPY . .
RUN npm run build

# nginx container runs on port 80; so map your docker run -p 5001:80 container id 
FROM nginx
# exposing port 80 for Elastic Beanstalk
EXPOSE 80 
COPY --from=builder /app/build /usr/share/nginx/html


