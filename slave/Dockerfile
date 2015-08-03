FROM oberthur/docker-ubuntu-java:jdk8_8.51.16

MAINTAINER Dawid Malinowski <d.malinowski@oberthur.com>

ENV HOME /opt/jenkins-slave
ENV _JAVA_OPTIONS=-Duser.home=/opt/jenkins-slave
ENV SWARM_VERSION 2.0

WORKDIR /opt/jenkins-slave

RUN mkdir -p /opt/jenkins-slave \
    && curl -o /opt/jenkins-slave/swarm-client-$SWARM_VERSION-jar-with-dependencies.jar http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/$SWARM_VERSION/swarm-client-$SWARM_VERSION-jar-with-dependencies.jar \
    && echo '#!/bin/bash -x\n\njava -jar /opt/jenkins-slave/swarm-client-$SWARM_VERSION-jar-with-dependencies.jar -disableClientsUniqueId -username $JENKINS_USERNAME -password $JENKINS_PASSWORD -mode ${JENKINS_MODE:-exclusive} -name $JENKINS_SLAVE_NAME -executors ${JENKINS_EXEC_NR:-1} -master ${JENKINS_URL:-127.0.0.1} -fsroot $JENKINS_FS_ROOT -labels "${JENKINS_LABELS:-swarm}"' > /usr/bin/swarm_slave.sh \
    && chmod +x /usr/bin/swarm_slave.sh \
    && mkdir -p /etc/supervisor/conf.d \
    && echo "[program:swarm-slave]\ncommand=/usr/bin/swarm_slave.sh\nuser=jenkins-slave" > /etc/supervisor/conf.d/supervisor.conf \

    # Make sure the package repository is up to date.
    && apt-get update \
    && apt-get install -y git supervisor \

    # clean all cache to clean space
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && apt-get -y autoremove \

    # add user jenkins-slave
    && groupadd -g 998 998 \
    && groupadd -g 999 999 \
    && useradd -u 500 jenkins-slave -U -s /bin/false \
    && usermod -a -G 998 jenkins-slave \
    && usermod -a -G 999 jenkins-slave \
    && chown -R jenkins-slave:jenkins-slave /opt/

ENTRYPOINT [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf" ]
