FROM oberthur/docker-ubuntu-java:jdk8_8.77.03

ENV SWARM_VERSION=2.0

# Add external repository
RUN add-apt-repository -y ppa:brightbox/ruby-ng-experimental

RUN curl -o /opt/swarm-client-${SWARM_VERSION}-jar-with-dependencies.jar http://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${SWARM_VERSION}/swarm-client-${SWARM_VERSION}-jar-with-dependencies.jar \
  && echo '#!/bin/bash\n\nexec java -jar /opt/swarm-client-$SWARM_VERSION-jar-with-dependencies.jar -disableClientsUniqueId -username $JENKINS_USERNAME -password $JENKINS_PASSWORD -mode ${JENKINS_MODE:-exclusive} -name $JENKINS_SLAVE_NAME -executors ${JENKINS_EXEC_NR:-1} -master ${JENKINS_URL:-127.0.0.1} -fsroot $JENKINS_FS_ROOT -labels "${JENKINS_LABELS:-swarm}"' > /usr/bin/swarm_slave.sh \
  && chmod +x /usr/bin/swarm_slave.sh \
  && mkdir -p /etc/supervisor/conf.d \
  && echo "[program:swarm-slave]\ncommand=/usr/bin/swarm_slave.sh\nuser=root" > /etc/supervisor/conf.d/supervisor.conf \

  # Make sure the package repository is up to date.
  && apt-get update \
  && apt-get install -y git supervisor openssh-client unzip wget bzip2 gitstats python-yaml libyaml-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev \

  # Install ruby deps
  && apt-get -y install ruby2.1 libmysqlclient18 build-essential libssl-dev libreadline-dev zlib1g-dev libsqlite3-dev libmysqlclient-dev bundler libgmp3-dev \
  && gem install bundler --no-ri --no-rdoc \

  # clean all cache to clean space
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean \
  && apt-get -y autoremove

ENTRYPOINT [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf" ]
