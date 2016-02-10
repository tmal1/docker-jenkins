FROM oberthur/jenkins-slave-base:2.0.2

ENV SBT_VERSION=0.13.9 \
    SBT_HOME=/usr/share/sbt
    _JAVA_OPTIONS="-Dsbt.log.noformat=true ${_JAVA_OPTIONS}"

RUN mkdir -p $SBT_HOME \
  && curl -L https://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/$SBT_VERSION/sbt-launch.jar > $SBT_HOME/sbt-launch.jar \
  && echo '#!/bin/bash\njava $SBT_OPTS -jar $SBT_HOME/sbt-launch.jar "$@"' > /usr/bin/sbt \
  && chmod a+x /usr/bin/sbt \
  && sbt exit \
  && chown -R jenkins-slave:jenkins-slave /opt/jenkins-slave/ \
  && rm -fr /tmp/*
