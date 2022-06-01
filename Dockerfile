FROM node:18

USER node

WORKDIR /home/node/foundry
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH=$PATH:/home/node/.npm-global/bin
ENV PATH=$PATH:/home/node/.foundry/bin

RUN npm install -g nodemon
RUN curl -L https://foundry.paradigm.xyz | bash

RUN foundryup