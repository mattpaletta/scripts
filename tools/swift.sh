_SWIFT_VERSION=4.2.1
_SWIFT_FLAVOUR=RELEASE

_swift_installed=false
command -v swift
if [[ $? == 0 ]]; then
  _swift_installed=true
  echo "Found Swift"
else
  echo "Swift Not Found"
fi

function install_swift() {
  if [[ $is_linux == 0 ]]; then
    if [[ "$_swift_installed" == false ]]; then
      $python

      echo "deb http://bg.archive.ubuntu.com/ubuntu/ trusty-security main" >> /etc/apt/sources.list
      echo "deb-src http://bg.archive.ubuntu.com/ubuntu/ trusty-updates main" >> /etc/apt/sources.list

      CURL_PACKAGE=$(apt search libcurl | grep "^libcurl[0-9]/"|  sed -e "/libcurl[0-9]/q" | cut -d'/' -f 1)

      # basic dependencies
      apt-get -qq update -y && apt-get -qq install -y git python3-pip cmake wget git build-essential

      # swift
      apt-get -qq install -y lsb-release
      UBUNTU_VERSION=$(lsb_release -r | awk '{print $2}')
      echo "Ubuntu Version: $UBUNTU_VERSION"

      if [[ ! -f ./swift-${_SWIFT_VERSION}-${_SWIFT_FLAVOUR}-ubuntu${UBUNTU_VERSION}.tar.gz ]];
      then
        wget https://swift.org/builds/swift-${_SWIFT_VERSION}-release/ubuntu$(echo $UBUNTU_VERSION | sed 's/\.//g')/swift-${_SWIFT_VERSION}-${_SWIFT_FLAVOUR}/swift-${_SWIFT_VERSION}-${_SWIFT_FLAVOUR}-ubuntu${UBUNTU_VERSION}.tar.gz
      fi

      # Swift dependencies
      apt-get -qq -y install clang libicu-dev libpython2.7 $CURL_PACKAGE
      wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import -

      gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift
      rm -rf ~/.swift
      mkdir ~/.swift
      tar xzf swift-${_SWIFT_VERSION}-${_SWIFT_FLAVOUR}-ubuntu${UBUNTU_VERSION}.tar.gz --strip-components 1 -C /opt/swift
#      echo "export PATH=~/.swift/usr/bin:$PATH" >> ~/.bash_profile

      ln -s /opt/swift/usr/bin/swift /usr/local/bin/swift && \

#      source ~/.bash_profile
      rm -f swift-${_SWIFT_VERSION}-${_SWIFT_FLAVOUR}-ubuntu${UBUNTU_VERSION}.tar.gz
      _swift_installed=true
    fi
  fi
}
swift=install_swift