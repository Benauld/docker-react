FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# post exposed in nginx container which is picked up by Elastic Beanstalk
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html