FROM oberthur/docker-ubuntu-java:jdk8_8.51.16

MAINTAINER Dawid Malinowski <d.malinowski@oberthur.com>

WORKDIR /opt
ENV BRANCH master

RUN apt-get update \
    && apt-get install -y python-setuptools python-dev libyaml-dev git \
    # install python deps
    && easy_install pip \
    && pip install PyYAML \
    && pip install six pbr

RUN git clone https://github.com/oberthur/jenkins-job-builder.git \
    && cd jenkins-job-builder \
    && git checkout $BRANCH \
    && python setup.py install \
    # override python-jenkins with own version
    && git clone https://github.com/oberthur/python-jenkins.git \
    && cd python-jenkins \
    && git checkout $BRANCH \
    && python setup.py install

# clean all cache to clean space
RUN apt-get -y purge git \
    && rm -rf /var/lib/apt/lists/* \
    && rm -fr /opt/jenkins-job-builder \
    && rm -fr /opt/python-jenkins \
    && apt-get -y autoremove \
    && apt-get clean

ENTRYPOINT ["/usr/local/bin/jenkins-jobs"]
