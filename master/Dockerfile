FROM oberthur/docker-ubuntu-java:jdk8_8.92.14

MAINTAINER Dawid Malinowski <d.malinowski@oberthur.com>

ENV JENKINS_VERSION 2.7.2

RUN mkdir -p /var/lib/jenkins/ /usr/share/jenkins/ /var/cache/jenkins/war/ /var/log/jenkins/ \
    && curl -o /usr/share/jenkins/jenkins.war http://mirrors.jenkins-ci.org/war-stable/$JENKINS_VERSION/jenkins.war -L \
    && groupadd -g 999 app \
    && useradd -u 999 app -g app -s /bin/false -M -d /var/lib/jenkins \
    && apt-get update \
    && apt-get install -y supervisor git openssh-client \
    # clean all cache to clean space
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && echo '#!/bin/bash\n\nexec java -Xms${JVM_MINIMUM_MEMORY:=1024m} -Xmx${JVM_MAXIMUM_MEMORY:=2048m} ${JAVA_OPTS} -Djava.awt.headless=true -Dhudson.model.DirectoryBrowserSupport.CSP="sandbox\;" -DJENKINS_HOME=/var/lib/jenkins -jar /usr/share/jenkins/jenkins.war --logfile=/var/log/jenkins/jenkins.log --webroot=/var/cache/jenkins/war --httpPort=${JENKINS_PORT:-8080} --prefix=${JENKINS_PREFIX:-/jenkins}' > /usr/bin/jenkins_master.sh \
    && chmod 755 /usr/bin/jenkins_master.sh && echo "[program:jenkins-master]\ncommand=/usr/bin/jenkins_master.sh\nuser=app" > /etc/supervisor/conf.d/supervisor.conf \
    && chown app:app /var/lib/jenkins /usr/share/jenkins/ /var/cache/jenkins/war/

    ENTRYPOINT [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf" ]
