FROM oberthur/jenkins-slave-base:2.0.2

ENV MAVEN_VERSION=3.3.3 \
    MAVEN_HOME=/usr/share/maven \
    PATH=/usr/bin/_docker:$PATH \
    NPM_CONFIG_LOGLEVEL=info

RUN curl -fsSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn \
  && apt-get update && apt-get install -y nodejs npm bzip2 \
  && ln -s /usr/bin/nodejs /usr/bin/node
