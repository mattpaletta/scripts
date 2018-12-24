set -e

sudo apt-get update -y 
sudo apt-get install -y vim git

NAME=""
EMAIL=""

skip_ruby_from_ppa=TRUE
install_curl_from_source=FALSE

# swift
SWIFT_VERSION=4.2.1
SWIFT_FLAVOUR=RELEASE
UBUNTU_VERSION=$(lsb_release -r | awk '{print $2}')
echo $UBUNTU_VERSION

# basic dependencies
apt-get update && sudo apt-get install -y vim git python3-pip cmake wget git build-essential

# Setup Git
# git config --global user.email $EMAIL
# git config --global user.name $NAME

# local
# TODO:// Finish configuring locales
#locale-gen en_US.UTF-8 && locale-gen en_US en_US.UTF-8 && dpkg-reconfigure locales && echo 'export LANG=en_US.UTF-8' >> $HOME/.profile && echo 'export LANGUAGE=en_US:en' >> $HOME/.profile && echo 'export LC_ALL=en_US.UTF-8' >> $HOME/.profile

# TODO:// Replace 18.04 with sed replace ubuntu version
wget https://swift.org/builds/swift-$SWIFT_VERSION-release/ubuntu$(echo $UBUNTU_VERSION | sed 's/\.//g')/swift-$SWIFT_VERSION-$SWIFT_FLAVOUR/swift-$SWIFT_VERSION-$SWIFT_FLAVOUR-ubuntu$UBUNTU_VERSION.tar.gz 

# Swift dependencies
sudo apt-get -y install clang libicu-dev libpython2.7 libcurl4

wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import -

gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift
rm -rf ~/.swift
mkdir ~/.swift
tar xzf swift-$SWIFT_VERSION-$SWIFT_FLAVOUR-ubuntu$UBUNTU_VERSION.tar.gz --strip-components 1 -C ~/.swift
echo "export PATH=~/.swift/usr/bin:$PATH" >> ~/.bash_profile

# Python3
pip3 install virtualenv mypy

# Data Science
pip3 install pandas numpy tensorflow scikit-learn pyspark

# Ops
pip3 install docker

source ~/.bash_profile
