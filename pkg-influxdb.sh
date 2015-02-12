#!/bin/bash

set -e

while getopts ":t:" o; do
	case "$o" in
		t)
			tag="${OPTARG}"
			;;
	esac
done

shift $(($OPTIND - 1))

#gem install --no-rdoc --no-ri fpm

mkdir -p go/src/github.com/influxdb && cd go/src/github.com/influxdb
git clone http://github.com/influxdb/influxdb && cd influxdb

if [ -n "$tag" ]; then
	git checkout $tag
fi

cd cmd/influxd

go get -u -f
go build

cp influxd /vmshare
