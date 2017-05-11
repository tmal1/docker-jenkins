FROM oberthur/docker-centos_i386-gcc

LABEL author="Tomasz Malinowski <t.malinowski@oberthur.com>"
LABEL type="docker-centos_i386-rpmbuilder-2.6.32-696.1.1.el6.i686"

ENV SWARM_VERSION=2.2

COPY rpmmacros /root/.rpmmacros

RUN curl -o /opt/swarm-client-${SWARM_VERSION}-jar-with-dependencies.jar http://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${SWARM_VERSION}/swarm-client-${SWARM_VERSION}-jar-with-dependencies.jar \
  && echo '#!/bin/bash\n\nexec java -jar /opt/swarm-client-$SWARM_VERSION-jar-with-dependencies.jar -disableClientsUniqueId -username $JENKINS_USERNAME -password $JENKINS_PASSWORD -mode ${JENKINS_MODE:-exclusive} -name $JENKINS_SLAVE_NAME -executors ${JENKINS_EXEC_NR:-1} -master ${JENKINS_URL:-127.0.0.1} -fsroot $JENKINS_FS_ROOT -labels "${JENKINS_LABELS:-swarm}"' > /usr/bin/swarm_slave.sh \
  && echo '#!/bin/bash\n\nif [ -n "${SOCAT_LOCAL_PORT}" ] && [ -n "${SOCAT_REMOTE_HOST}" ] && [ -n "${SOCAT_REMOTE_PORT}" ] ; then\n  echo Connecting to ${SOCAT_REMOTE_HOST}:${SOCAT_REMOTE_PORT}via${SOCAT_LOCAL_PORT} ...\n  exec socat -t 100000000 TCP4-LISTEN:${SOCAT_LOCAL_PORT},fork,reuseaddr TCP4:${SOCAT_REMOTE_HOST}:${SOCAT_REMOTE_PORT}\nfi\n' > /usr/bin/socat_slave.sh \
  && chmod +x /usr/bin/*_slave.sh \
  && mkdir -p /etc/supervisor/conf.d \
  && echo "[program:swarm-slave]\ncommand=/usr/bin/swarm_slave.sh\nuser=root\n\n[program:socat-slave]\ncommand=/usr/bin/socat_slave.sh\nuser=root" > /etc/supervisor/conf.d/supervisor.conf \

  && yum -y update \
  && yum install -y yum-plugin-ovl kernel-2.6.32-696.1.1.el6.i686 kernel-headers-2.6.32-696.1.1.el6.i686 kernel-devel-2.6.32-696.1.1.el6.i686 rpmdevtools supervisor \
  && rpmdev-setuptree \

# clean all cache to clean space \
  && rm -rf /var/cache/yum/* \
  && yum clean all

ENTRYPOINT [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf" ]
