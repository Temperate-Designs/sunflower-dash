FROM gitpod/workspace-full-vnc
SHELL ["/bin/bash", "-c"]

ENV ANDROID_HOME=/home/gitpod/androidsdk
ENV FLUTTER_VERSION=2.5.2-stable

# Install dart
USER root
RUN curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN curl -fsSL https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list
RUN apt-get update
RUN apt-get install --yes \
    build-essential \
    dart \
    libkrb5-dev \
    gcc \
    make \
    gradle \
    android-tools-adb \
    android-tools-fastboot

# Install flutter
USER gitpod
WORKDIR /home/gitpod

RUN wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}.tar.xz
RUN tar -xvf flutter*.tar.xz
RUN rm -f flutter*.tar.xz

RUN flutter/bin/flutter precache
RUN echo 'export PATH="$PATH:/home/gitpod/flutter/bin"' >> /home/gitpod/.bashrc

# Install SDK Manager
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip
RUN mkdir -p ${ANDROID_HOME}/cmdline-tools/latest
RUN unzip commandlinetools-linux-*.zip -d ${ANDROID_HOME}
RUN rm -f commandlinetools-linux-*.zip
RUN mv ${ANDROID_HOME}/cmdline-tools/bin ${ANDROID_HOME}/cmdline-tools/latest
RUN mv ${ANDROID_HOME}/cmdline-tools/lib ${ANDROID_HOME}/cmdline-tools/latest

RUN echo "export ANDROID_HOME=${ANDROID_HOME}" >> /home/gitpod/.bashrc
RUN echo 'export PATH=${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools:${ANDROID_HOME}/cmdline-tools/bin:${ANDROID_HOME}/platform-tools:${PATH}' >> /home/gitpod/.bashrc

# Install Android Image version 30
RUN yes | ${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager "platform-tools" "platforms;android-30" "emulator"
RUN yes | ${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager "system-images;android-30;google_apis;x86_64"
RUN echo no | ${ANDROID_HOME}/cmdline-tools/latest/bin/avdmanager create avd -n avd28 -k "system-images;android-30;google_apis;x86_64"

# Install Google Chrome
USER root
WORKDIR /root
RUN apt-get update
RUN apt-get install --yes apt-transport-https
RUN curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
RUN apt-get update
RUN sudo apt-get install --yes google-chrome-stable

# misc deps
RUN apt-get install --yes \
  libasound2-dev \
  libgtk-3-dev \
  libnss3-dev \
  fonts-noto \
  fonts-noto-cjk

# For Qt WebEngine on docker
ENV QTWEBENGINE_DISABLE_SANDBOX 1
