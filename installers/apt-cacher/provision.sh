#!/bin/bash

echo "Installing dependencies with apt-get"
apt-get -y install apt-cacher-ng

service apt-cacher-ng stop

echo "Acquire::http::proxy \"http://localhost:3142\";" > /etc/apt/apt.conf.d/01proxy

echo "RequestAppendix: Cookie: oraclelicense=a" >>  /etc/apt-cacher-ng/acng.conf
echo "PfilePatternEx: (/dists/.*/by-hash/.*|\.yml)$" >>  /etc/apt-cacher-ng/acng.conf
echo "PassThroughPattern: (download.docker.com:443)$" >> /etc/apt-cacher-ng/acng.conf

service apt-cacher-ng start

apt-get -y update

echo ""
