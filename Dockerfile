FROM debian

RUN apt-get update && \
    apt-get install -y mercurial bzr protobuf-compiler flex bison \
      valgrind g++ make autoconf libtool libz-dev libbz2-dev curl \
      rpm build-essential git wget gawk sudo procps ruby-dev vim \
      locales bundler

RUN curl -o go.tar.gz https://storage.googleapis.com/golang/go1.5.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go.tar.gz

RUN mkdir -p go/bin go/pkg go/src 

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN curl -sSL https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c rvm requirements
RUN /bin/bash -l -c "source /usr/local/rvm/scripts/rvm && rvm install ruby-1.9.3-p547"

ENV PATH $PATH:/usr/local/go/bin:/usr/local/rvm/bin:/go/bin

RUN go get -u github.com/golang/protobuf/{proto,protoc-gen-go}

ADD pkg-influxdb.sh /
RUN chmod ug+rwx /pkg-influxdb.sh
