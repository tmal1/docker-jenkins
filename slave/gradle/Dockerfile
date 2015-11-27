FROM oberthur/jenkins-slave-base:2.0.1

ENV GRADLE_VERSION 2.9
ENV GRADLE_HOME /usr/share/gradle

RUN apt-get update \
    && apt-get install -y unzip \
    && curl -L https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-all.zip > /usr/share/gradle-$GRADLE_VERSION-all.zip \
    && unzip -d /usr/share/ /usr/share/gradle-$GRADLE_VERSION-all.zip \
    && ln -s /usr/share/gradle-$GRADLE_VERSION /usr/share/gradle \
    && rm /usr/share/gradle-$GRADLE_VERSION-all.zip \
    && ln -s /usr/share/gradle/bin/gradle /usr/bin/gradle \
    && apt-get purge -y unzip \
    && apt-get clean \
    && apt-get -y autoremove
