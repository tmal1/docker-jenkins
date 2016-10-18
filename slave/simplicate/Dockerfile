FROM ubuntu:14.04

ENV SWARM_VERSION=2.2 \
  ANT_VERSION=1.9.4 \
  ANT_HOME=/usr/share/ant \
  PHANTOMJS_VERSION=2.1.1 \
  PHANTOMJS_PLATFORM=linux-x86_64 \
  PATH=~/.rbenv/bin:$PATH

# Add external repository
#RUN add-apt-repository -y ppa:brightbox/ruby-ng-experimental \
#  && add-apt-repository -y ppa:openjdk-r/ppa 

RUN apt-get install -y curl

RUN curl -o /opt/swarm-client-${SWARM_VERSION}-jar-with-dependencies.jar http://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${SWARM_VERSION}/swarm-client-${SWARM_VERSION}-jar-with-dependencies.jar \
  && echo '#!/bin/bash\n\nexec java -jar /opt/swarm-client-$SWARM_VERSION-jar-with-dependencies.jar -disableClientsUniqueId -username $JENKINS_USERNAME -password $JENKINS_PASSWORD -mode ${JENKINS_MODE:-exclusive} -name $JENKINS_SLAVE_NAME -executors ${JENKINS_EXEC_NR:-1} -master ${JENKINS_URL:-127.0.0.1} -fsroot $JENKINS_FS_ROOT -labels "${JENKINS_LABELS:-swarm}"' > /usr/bin/swarm_slave.sh \
  && chmod +x /usr/bin/swarm_slave.sh \
  && mkdir -p /etc/supervisor/conf.d \
  && echo "[program:swarm-slave]\ncommand=/usr/bin/swarm_slave.sh\nuser=root" > /etc/supervisor/conf.d/supervisor.conf \

  # Install ant
  && curl -fsSL http://archive.apache.org/dist/ant/binaries/apache-ant-$ANT_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-ant-$ANT_VERSION /usr/share/ant \
  && ln -s /usr/share/ant/bin/ant /usr/bin/ant \

  # Make sure the package repository is up to date.
  && dpkg --add-architecture i386 \
  && apt-get update \
  && apt-get install -y git supervisor openssh-client zip unzip wget bzip2 file make dos2unix \
  
  # Add SIM deps
  && apt-get -y install libomnithread3-dev:i386 libomniorb4-dev:i386 libcurl4-openssl-dev:i386 python-dev:i386 \
  && apt-get -y install binutils:i386 g++:i386 gcc:i386 omniidl:i386 omniorb:i386 libaio-dev:i386 \
  && apt-get -y install --no-install-recommends openjdk-7-jdk flex:i386 sudo \

  # clean all cache to clean space
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean \
  && apt-get -y autoremove \

ENTRYPOINT [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf" ]
