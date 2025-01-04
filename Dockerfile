FROM node:latest

USER root

RUN apt-get update && \
    apt-get install -y \
    docker.io \
    git \
    curl && \
    apt-get clean

WORKDIR /app

RUN git clone https://github.com/hydralabs-beta/daemon.git . 
RUN cd daemon

RUN npm install

# Command to start the app
CMD ["sh", "-c", "npm run configure -- --panel $PANEL_URL --key $PANEL_KEY && node index.js"]
