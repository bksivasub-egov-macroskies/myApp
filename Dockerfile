FROM node:6.14.2
EXPOSE 8080
COPY /data/myApp/server.js .
CMD [ "node", "server.js" ]
