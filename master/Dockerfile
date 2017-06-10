FROM oberthur/docker-ubuntu-java:jdk8_8.121.13

MAINTAINER Dawid Malinowski <d.malinowski@oberthur.com>

ENV JENKINS_VERSION 2.46.3  

COPY supervisor.conf /etc/supervisor/conf.d/supervisor.conf
COPY jenkins_master.sh /usr/bin/jenkins_master.sh

RUN mkdir -p /var/lib/jenkins/ /usr/share/jenkins/ /var/cache/jenkins/war/ /var/log/jenkins/ \
    && curl -o /usr/share/jenkins/jenkins.war http://mirrors.jenkins-ci.org/war-stable/$JENKINS_VERSION/jenkins.war -L \
    && usermod -s /bin/false -d /var/lib/jenkins app\
    && apt-get update \
    && apt-get install -y supervisor git openssh-client \
    # clean all cache to clean space
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/ \
    && chmod 755 /usr/bin/jenkins_master.sh \
    && chown app:app /var/lib/jenkins /usr/share/jenkins/ /var/cache/jenkins/war/ /var/log/jenkins

ENTRYPOINT [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf" ]
