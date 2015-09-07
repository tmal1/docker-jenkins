FROM oberthur/jenkins-slave-base:2.0

ENV DOCKER_VERSION 1.7.1

# Add docker
RUN apt-get update && apt-get install -y apt-transport-https \
    && echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9 \
    && apt-get update \
    && apt-get install -y lxc-docker-$DOCKER_VERSION \

# Make sure the package repository is up to date.
RUN apt-get update \
    && apt-get install -y ansible python-pycurl bsdtar genisoimage sshpass \
    && echo "[local]\n127.0.0.1" > /etc/ansible/hosts

# clean all cache to clean space
RUN rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && apt-get -y autoremove

USER root
