FROM oberthur/docker-centos_i386-gcc

LABEL author="Tomasz Malinowski <t.malinowski@oberthur.com>"
LABEL type="docker-centos_i386-rpmbuilder-2.6.32-696.1.1.el6.i686"

ENV SWARM_VERSION=2.2

COPY rpmmacros /root/.rpmmacros

RUN curl -o /opt/swarm-client-${SWARM_VERSION}-jar-with-dependencies.jar http://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${SWARM_VERSION}/swarm-client-${SWARM_VERSION}-jar-with-dependencies.jar \
  && echo -e '#!/bin/bash\n\nexec java -jar /opt/swarm-client-$SWARM_VERSION-jar-with-dependencies.jar -disableClientsUniqueId -username $JENKINS_USERNAME -password $JENKINS_PASSWORD -mode ${JENKINS_MODE:-exclusive} -name $JENKINS_SLAVE_NAME -executors ${JENKINS_EXEC_NR:-1} -master ${JENKINS_URL:-127.0.0.1} -fsroot $JENKINS_FS_ROOT -labels "${JENKINS_LABELS:-swarm}"' > /usr/bin/swarm_slave.sh \
  && chmod +x /usr/bin/swarm_slave.sh \

  && yum -y update \
  && yum install -y yum-plugin-ovl python-setuptools kernel-2.6.32-696.1.1.el6.i686 kernel-headers-2.6.32-696.1.1.el6.i686 kernel-devel-2.6.32-696.1.1.el6.i686 rpmdevtools \

  && easy_install supervisor \
  && mkdir -p /etc/supervisord/conf.d \
  && echo_supervisord_conf > /etc/supervisord/supervisord.conf \
  && echo -e "\n[include]\nfiles = /etc/supervisord/conf.d/*.ini" >>  /etc/supervisord/supervisord.conf \
  && echo -e "[program:swarm_slave]\ncommand=/usr/bin/swarm_slave.sh\nuser=root" > /etc/supervisord/conf.d/supervisor.ini \

  && rpmdev-setuptree \

# clean all cache to clean space \
  && rm -rf /var/cache/yum/* \
  && yum clean all

ENTRYPOINT [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisord/supervisord.conf" ]
