#!/usr/bin/env bash
set -e

echo "deb http://bg.archive.ubuntu.com/ubuntu/ trusty-security main" >> /etc/apt/sources.list
echo "deb-src http://bg.archive.ubuntu.com/ubuntu/ trusty-updates main" >> /etc/apt/sources.list

CURL_PACKAGE=$(apt search libcurl | grep "^libcurl[0-9]/"|  sed -e "/libcurl[0-9]/q" | cut -d'/' -f 1)

# basic dependencies
apt-get update && \
    sudo apt-get install -y vim git python3-pip cmake wget git build-essential

# swift
SWIFT_VERSION=4.2.1
SWIFT_FLAVOUR=RELEASE
UBUNTU_VERSION=$(lsb_release -r | awk '{print $2}')
echo "Ubuntu Version: $UBUNTU_VERSION"

wget https://swift.org/builds/swift-${SWIFT_VERSION}-release/ubuntu$(echo $UBUNTU_VERSION | sed 's/\.//g')/swift-${SWIFT_VERSION}-${SWIFT_FLAVOUR}/swift-${SWIFT_VERSION}-${SWIFT_FLAVOUR}-ubuntu${UBUNTU_VERSION}.tar.gz

# Swift dependencies
sudo apt-get -y install clang libicu-dev libpython2.7 CURL_PACKAGE
wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import -

gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift
rm -rf ~/.swift
mkdir ~/.swift
tar xzf swift-${SWIFT_VERSION}-${SWIFT_FLAVOUR}-ubuntu${UBUNTU_VERSION}.tar.gz --strip-components 1 -C ~/.swift
echo "export PATH=~/.swift/usr/bin:$PATH" >> ~/.bash_profile

source ~/.bash_profile