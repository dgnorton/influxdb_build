FROM debian

RUN apt-get update && apt-get install -y \
	curl \
	gcc \
	git \
	mercurial \
	sudo \
	vim \
	locales \
	rpm \
	wget \
	ruby-dev \
	make

RUN curl -o go.tar.gz https://storage.googleapis.com/golang/go1.4.1.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go.tar.gz
ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH /go

RUN mkdir -p go/bin go/pkg go/src 

ADD pkg-influxdb.sh /
RUN chmod ug+rwx /pkg-influxdb.sh
