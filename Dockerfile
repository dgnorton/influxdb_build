FROM debian

RUN apt-get update && \
    apt-get install -y mercurial bzr protobuf-compiler flex bison \
      valgrind g++ make autoconf libtool libz-dev libbz2-dev curl \
      rpm build-essential git wget gawk sudo procps ruby-dev vim \
      locales bundler

RUN curl -o go.tar.gz https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go.tar.gz
ENV PATH $PATH:/usr/local/go/bin

RUN mkdir -p go/bin go/pkg go/src 

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable
ENV PATH $PATH:/usr/local/rvm/bin
RUN /bin/bash -l -c rvm requirements
RUN /bin/bash -l -c "source /usr/local/rvm/scripts/rvm && rvm install ruby-1.9.3-p547"

ADD pkg-influxdb.sh /
RUN chmod ug+rwx /pkg-influxdb.sh

ADD package.sh /
RUN chmod ug+rx /package.sh
