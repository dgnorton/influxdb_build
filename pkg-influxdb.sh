#!/bin/bash

set -e

while getopts ":t:v:" o; do
	case "$o" in
		t)
			tag="${OPTARG}"
			;;
		v)
			ver="${OPTARG}"
			;;
	esac
done

shift $(($OPTIND - 1))

if [ -z "$ver" ]; then
	echo pkg-influxdb.sh -v <version> [ -t <tag or sha1> ]
	exit 1
fi

rvm use 1.9.3@influxdb
gem install --no-rdoc --no-ri fpm

mkdir -p go/src/github.com/influxdb && cd go/src/github.com/influxdb
git clone http://github.com/influxdb/influxdb && cd influxdb

if [ -n "$tag" ]; then
	git checkout $tag
fi

#./configure && make package && cp -r packages /vmshare

cp /package.sh . && GOPATH=/go ./package.sh $ver
