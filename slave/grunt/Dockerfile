FROM oberthur/jenkins-slave-base:2.0.1

ENV NPM_CONFIG_LOGLEVEL info

RUN apt-get update && apt-get install -y nodejs npm \
    && ln -s /usr/bin/nodejs /usr/bin/node
#RUN npm install -g grunt-cli yo bower generator-cg-angular
