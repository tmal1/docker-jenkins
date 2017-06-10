#!/bin/bash

exec java \
  -Xms${JVM_MINIMUM_MEMORY:=1024m} \
  -Xmx${JVM_MAXIMUM_MEMORY:=2048m} ${JAVA_OPTS} \
  -Djava.awt.headless=true \
  -Dhudson.model.DirectoryBrowserSupport.CSP="sandbox\;" \
  -DJENKINS_HOME=/var/lib/jenkins \
  -jar /usr/share/jenkins/jenkins.war \
  --logfile=/var/log/jenkins/jenkins.log \
  --webroot=/var/cache/jenkins/war \
  --httpPort=${JENKINS_PORT:-8080} \
  --prefix=${JENKINS_PREFIX:-/jenkins}
