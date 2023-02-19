# Use nginx to serve the application ##
FROM node:14.17.6 AS builder

WORKDIR /Week4Docker

COPY packages*.json ./

## Remove default nginx website  
RUN npm install

COPY . .

## Copy over the artifacts in dist folder to default nginx public folder  
RUN npm run build

FROM nginx:latest

COPY --from=builder /Week4Docker/dist/Week4Docker /usr/share/nginx/html
## nginx will run in the forground 

COPY ./ngix.conf /etc/nginx/conf.d/default.conf

CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
