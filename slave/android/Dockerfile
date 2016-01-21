FROM oberthur/jenkins-slave-base:2.0.2

MAINTAINER Kacper Piechota <k.piechota@oberthur.com>

ENV MAVEN_VERSION=3.2.3 \
    MAVEN_HOME=/usr/share/maven \
    ANDROID_VERSION=22 \
    ANDROID_HOME=/opt/android-sdk-linux/ \
    GRADLE_VERSION=2.5 \
    GRADLE_HOME=/opt/gradle-2.5
ENV PATH $GRADLE_HOME/bin:$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH

RUN apt-get update \
  && apt-get install -y unzip libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 \
  && curl -fsSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn \
  && curl -LO https://dl.google.com/android/android-sdk_r24.3.3-linux.tgz \
  && mv android-sdk_r24.3.3-linux.tgz /opt/ \
  && cd /opt \
  && tar xzvf ./android-sdk_r24.3.3-linux.tgz \
  && rm android-sdk_r24.3.3-linux.tgz \
  && chmod -R 755 $ANDROID_HOME \
  && echo "y" | android update sdk --force --no-ui --all --filter platform-tools,build-tools-$ANDROID_VERSION.0.1,android-$ANDROID_VERSION,addon-google_apis-google-$ANDROID_VERSION,sys-img-x86-addon-google_apis-google-$ANDROID_VERSION,source-$ANDROID_VERSION,extra-android-m2repository,extra-google-m2repository \
  && mkdir -p /opt/android-sdk-linux/build-tools \
  && cd /opt/android-sdk-linux/build-tools \
  && curl -LO https://dl.google.com/android/repository/build-tools_r22.0.1-linux.zip \
  && unzip build-tools_r22.0.1-linux.zip \
  && rm build-tools_r22.0.1-linux.zip \
  && curl -LO https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip \
  && mv gradle-$GRADLE_VERSION-bin.zip /opt/. \
  && unzip /opt/gradle-$GRADLE_VERSION-bin.zip -d /opt \
  && rm /opt/gradle-$GRADLE_VERSION-bin.zip \
  && chmod -R 777 /opt/jenkins-slave/.android \
  && apt-get purge -y unzip \
  && apt-get clean \
  && apt-get -y autoremove
