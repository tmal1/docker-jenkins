FROM oberthur/jenkins-slave-maven:2.0.1

ENV NPM_CONFIG_LOGLEVEL info

RUN apt-get update && apt-get install -y nodejs npm bzip2 \
    && ln -s /usr/bin/nodejs /usr/bin/node
