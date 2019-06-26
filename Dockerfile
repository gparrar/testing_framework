FROM openjdk:8-slim
MAINTAINER Gonzalo Parra

ENV HOME /opt
ENV ROBOT_DIR /opt/mb/robot

WORKDIR ${HOME}

RUN apt-get update && apt-get install -y --no-install-recommends \
      wget \
      sudo \
      gnupg \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - \
    && echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list

RUN apt-get update && apt-get install -y --no-install-recommends \
      python \
      python-dev \
      python-pip \
      libpq-dev \
      build-essential \
      lsb-release \
      xvfb \
      ssh \
      x11-xserver-utils \
      xdotool \
      wmctrl \
      procps \
      libopencv-dev \
      tar \
      tesseract-ocr \
      google-chrome-stable \
      imagemagick \
      fluxbox \
  	&& rm -rf /var/lib/apt/lists/*

COPY  requirements.txt .
RUN pip install --upgrade setuptools wheel \
    && pip install -Ur requirements.txt

# Install maven
RUN wget https://apache.osuosl.org/maven/maven-3/3.6.1/binaries/apache-maven-3.6.1-bin.tar.gz
RUN tar xvf apache-maven-3.6.1-bin.tar.gz -C /usr/local/
RUN rm apache-maven-3.6.1-bin.tar.gz

# Compile and install robot framework sikuli library
# COPY ./robotframework-SikuliLibrary/ ${HOME}
# RUN /usr/local/apache-maven-3.6.1/bin/mvn clean package
# RUN python setup.py install

# Install selenium chrome driver
RUN wget https://chromedriver.storage.googleapis.com/74.0.3729.6/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip -d /usr/bin/
RUN rm chromedriver_linux64.zip

# Install Jmeter
# RUN wget -c http://ftp.cixug.es/apache//jmeter/binaries/apache-jmeter-3.3.tgz
# RUN tar -xf apache-jmeter-3.3.tgz && rm apache-jmeter-3.3.tgz && mv apache-jmeter-3.3 jmeter
# ENV JMETER_HOME ${HOME}/jmeter

# Tweaks
RUN sed -i "s/assistive_technologies/#assistive_technologies/g" /etc/java-8-openjdk/accessibility.properties
#RUN echo "    IdentityFile ~/.ssh/id_rsa" >> /etc/ssh/ssh_config
RUN useradd robot
RUN echo "robot ALL=NOPASSWD: ALL" >> /etc/sudoers

# SSH Keys & Credentials
# RUN mkdir /root/.ssh/
# COPY resources/ssh-keys/id_rsa /root/.ssh/id_rsa
# COPY resources/ssh-keys/id_rsa.pub /root/.ssh/id_rsa.pub

RUN google-chrome --version

RUN mkdir -p $ROBOT_DIR
ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh
CMD ["run.sh"]
