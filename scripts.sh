apt-get update -y 
apt-get install -y vim git

NAME=""
EMAIL=""

skip_ruby_from_ppa=TRUE
install_curl_from_source=TRUE

# swift
SWIFT_VERSION=4.0.3
SWIFT_FLAVOUR=RELEASE
UBUNTU_VERSION=(lsb_release -r | awk '{print $2}')

# basic dependencies
apt-get update && apt-get install -y python3-pip cmake wget git build-essential software-properties-common pkg-config locales libicu-dev libblocksruntime0 lsof dnsutils netcat-openbsd net-tools # used by integration tests

# Setup Git
git config --global user.email $EMAIL
git config --global user.name $NAME

# local
locale-gen en_US.UTF-8 && locale-gen en_US en_US.UTF-8 && dpkg-reconfigure locales && echo 'export LANG=en_US.UTF-8' >> $HOME/.profile && echo 'export LANGUAGE=en_US:en' >> $HOME/.profile && echo 'export LC_ALL=en_US.UTF-8' >> $HOME/.profile

wget https://swift.org/builds/ubuntu1510/swift-$(SWIFT_VERSION)-SNAPSHOT-2015-12-10-a/swift-$(SWIFT_VERSION)-SNAPSHOT-2015-12-10-a-ubuntu$(UBUNTU_VERSION).tar.gz

# known hosts
mkdir -p $HOME/.ssh && touch $HOME/.ssh/known_hosts && ssh-keyscan github.com 2> /dev/null >> $HOME/.ssh/known_hosts

# clang
apt-get update && apt-get install -y clang-3.9 && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.9 100 && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.9 100

# modern curl, if needed
[ ! -z $install_curl_from_source ] || { apt-get update && \
    apt-get install -y curl libcurl4-openssl-dev libz-dev libssl-dev && \
    mkdir $HOME/.curl && \
    wget -q https://curl.haxx.se/download/curl-7.50.3.tar.gz -O $HOME/curl.tar.gz && \
    tar xzf $HOME/curl.tar.gz --directory $HOME/.curl --strip-components=1 && \
    cd $HOME/.curl && ./configure --with-ssl && make && make install && cd - ) && \
    ldconfig

# ruby and jazzy for docs generation
[ -n "$skip_ruby_from_ppa" ] || apt-add-repository -y ppa:brightbox/ruby-ng && \
    apt-get update && \
    apt-get install -y ruby ruby-dev libsqlite3-dev && \
    gem install jazzy --no-ri --no-rdoc


mkdir $HOME/.swift && \
    wget -q https://swift.org/builds/swift-${SWIFT_VERSION}-$(echo $SWIFT_FLAVOUR | tr A-Z a-z)/ubuntu$(echo $ubuntu_version | sed 's/\.//g')/swift-${SWIFT_VERSION}-${SWIFT_FLAVOUR}/swift-${SWIFT_VERSION}-${SWIFT_FLAVOUR}-ubuntu${ubuntu_version}.tar.gz -O $HOME/swift.tar.gz && \
    tar xzf $HOME/swift.tar.gz --directory $HOME/.swift --strip-components=1 && \
    echo 'export PATH="$HOME/.swift/usr/bin:$PATH"' >> $HOME/.profile && \
    echo 'export LINUX_SOURCEKIT_LIB_PATH="$HOME/.swift/usr/lib"' >> $HOME/.profile

# script to allow mapping framepointers on linux
mkdir -p $HOME/.scripts && \ 
    wget -q https://raw.githubusercontent.com/apple/swift/master/utils/symbolicate-linux-fatal -O $HOME/.scripts/symbolicate-linux-fatal && \
    chmod 755 $HOME/.scripts/symbolicate-linux-fatal && \
    echo 'export PATH="$HOME/.scripts:$PATH"' >> $HOME/.profile && \
    echo 'export PATH="$HOME.swift/usr/bin:$PATH"' >> $HOME/.bashrc

# Python3
pip3 install virtualenv mypy

# Data Science
pip3 install pandas numpy tensorflow scikit-learn pyspark

# Ops
pip3 install docker
