FROM oberthur/jenkins-slave-base:2.0.1

ENV SBT_VERSION 0.13.9
ENV SBT_HOME /usr/share/sbt

RUN mkdir -p $SBT_HOME \
  && curl -L https://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/$SBT_VERSION/sbt-launch.jar > $SBT_HOME/sbt-launch.jar \
  && echo '#!/bin/bash\njava $SBT_OPTS -jar $SBT_HOME/sbt-launch.jar "$@"' > /usr/bin/sbt \
  && chmod u+x /usr/bin/sbt \
  && sbt exit \
  && rm -fr /tmp/*
