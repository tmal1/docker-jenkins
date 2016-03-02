FROM oberthur/docker-ubuntu-java:jdk8_8.74.02

ENV SWARM_VERSION=2.0 \
  GRADLE_VERSION=2.10 \
  SBT_VERSION=0.13.9 \
  MAVEN_VERSION=3.3.3 \
  GRADLE_HOME=/usr/share/gradle \
  SBT_HOME=/usr/share/sbt \
  MAVEN_HOME=/usr/share/maven \
  NPM_CONFIG_LOGLEVEL=info \
  _JAVA_OPTIONS="-Dsbt.log.noformat=true"

RUN curl -o /opt/swarm-client-$SWARM_VERSION-jar-with-dependencies.jar http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/$SWARM_VERSION/swarm-client-$SWARM_VERSION-jar-with-dependencies.jar \
  && echo '#!/bin/bash -x\n\njava -jar /opt/swarm-client-$SWARM_VERSION-jar-with-dependencies.jar -disableClientsUniqueId -username $JENKINS_USERNAME -password $JENKINS_PASSWORD -mode ${JENKINS_MODE:-exclusive} -name $JENKINS_SLAVE_NAME -executors ${JENKINS_EXEC_NR:-1} -master ${JENKINS_URL:-127.0.0.1} -fsroot $JENKINS_FS_ROOT -labels "${JENKINS_LABELS:-swarm}"' > /usr/bin/swarm_slave.sh \
  && chmod +x /usr/bin/swarm_slave.sh \
  && mkdir -p /etc/supervisor/conf.d \
  && echo "[program:swarm-slave]\ncommand=/usr/bin/swarm_slave.sh\nuser=root" > /etc/supervisor/conf.d/supervisor.conf \

  # Make sure the package repository is up to date.
  && apt-get update \
  && apt-get install -y git supervisor openssh-client unzip wget bzip2 nodejs npm gitstats \
  && npm install npm -g \
  && npm install -g bower \
  && ln -s /usr/bin/nodejs /usr/bin/node \

  # install gradle 
  && curl -L https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-all.zip > /usr/share/gradle-$GRADLE_VERSION-all.zip \
  && unzip -d /usr/share/ /usr/share/gradle-$GRADLE_VERSION-all.zip \
  && ln -s /usr/share/gradle-$GRADLE_VERSION /usr/share/gradle \
  && rm /usr/share/gradle-$GRADLE_VERSION-all.zip \
  && ln -s /usr/share/gradle/bin/gradle /usr/bin/gradle \

  # clean all cache to clean space
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean \
  && apt-get -y autoremove \

  # install maven
  && curl -fsSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn \

  # install sbt
  && mkdir -p $SBT_HOME \
  && curl -L https://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/$SBT_VERSION/sbt-launch.jar > $SBT_HOME/sbt-launch.jar \
  && echo '#!/bin/bash\njava $SBT_OPTS -jar $SBT_HOME/sbt-launch.jar "$@"' > /usr/bin/sbt \
  && chmod a+x /usr/bin/sbt \
  && sbt exit \
  && rm -fr /tmp/*

ENTRYPOINT [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf" ]
