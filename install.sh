#!/bin/bash
# Utility Functions

is_mac() {
    return "$(uname)" == "Darwin"
}

is_linux() {
    return "$(expr substr $(uname -s) 1 5)" == "Linux"
}

BASE_URL="https://raw.githubusercontent.com/mattpaletta/scripts/master"

exec_script() {
    curl $1 | sh
}

run_platform() {
    exec_script ${BASE_URL}/platform/$1.sh
}

run_tool() {
    exec_script ${BASE_URL}/tools/$1.sh
}

run_tools() {
    for script in $1
    do
        echo "Installing ${script}"
        run_tool ${script}
    done
}
# *** DO NOT CHANGE HERE ***
# Source from: tools/brew.sh
_brew_has_installed=false
which -s brew
if [[ $? == 0 ]]; then
  _brew_has_installed=true
  echo "Found Brew"
else
  _brew_has_installed=false
  echo "Did not find Brew"
fi

function install_mac_brew() {
	which -s brew
	if [[ $? != 0 ]] ; then
		# Install Homebrew
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	else
		brew update
	fi
	
	echo "**Please install Command Line Tools"
	# Add Command Line Tools
	xcode-select --install
}

function install_brew() {
	if [[ "$_brew_has_installed" == false ]]; then
		echo "-- Installing Brew --"
		if [[ is_mac ]]; then
			call install_mac_brew
		elif [[ is_linux ]]; then
			# Do something under GNU/Linux platform
			# TODO Add brew for linux
			echo "Nothing to do"
		else
			echo "Unknown Platform"
			exit 1
		fi
		$_brew_has_installed=true
	else
		echo "Already installed Brew"
	fi
}

brew=install_brew




# *** DO NOT CHANGE HERE ***
# Source from: tools/cmake.sh
_cmake_has_installed=false
which -s cmake
if [[ $? == 0 ]]; then
  _cmake_has_installed=true
  echo "Found cmake"
else
  _cmake_has_installed=false
  echo "Did not find cmake"
fi

function install_linux_cmake() {
	CMAKE_MAJOR_VERSION=3.9
  CMAKE_MINOR_VERSION=2

  curl https://cmake.org/files/v${CMAKE_MAJOR_VERSION}/cmake-${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}-Linux-x86_64.sh -o /cmake-${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}-Linux-x86_64.sh && \
    mkdir /opt/cmake && \
    sh /cmake-${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}-Linux-x86_64.sh --prefix=/opt/cmake --skip-license && \
    ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake && \
    cmake --version
}

function install_cmake() {
	if [[ "$_cmake_has_installed" == false ]]; then
		echo "-- Installing cmake --"
		if [[ is_mac ]]; then
      $brew
      brew install cmake
		elif [[ is_linux ]]; then
      call install_linux_cmake
		else
			echo "Unknown Platform"
			exit 1
		fi
		$_cmake_has_installed=true
	else
		echo "Already installed cmake"
	fi
}

cmake=install_cmake



# *** DO NOT CHANGE HERE ***
# Source from: tools/cpp.sh
_cpp_has_installed=false
which -s gcc
if [[ $? == 0 ]]; then
  _cpp_has_installed=true
  echo "Found cpp"
else
  _cpp_has_installed=false
  echo "Did not find cpp"
fi

function install_cpp() {
	if [[ "$_cpp_has_installed" == false ]]; then
		echo "-- Installing c++"
		echo "DOING NOTHING YET"

		if [[ is_mac ]]; then
			echo "DOING NOTHING YET"
		elif [[ is_linux ]]; then
			echo "DOING NOTHING YET"
		else
			echo "Unknown Platform"
			exit 1
		fi
		$_cpp_has_installed=true
	else
		echo "Already installed cpp"
	fi
}

cpp=install_cpp




# *** DO NOT CHANGE HERE ***
# Source from: tools/docker.sh
_docker_installed=false
_docker_compose_installed=false
_docker_has_machine_installed=false

which -s docker
if [[ $? == 0 ]]; then
  _docker_installed=true
  echo "Found Docker"
else
  echo "Docker Not Found"
fi

which -s docker-compose
if [[ $? == 0 ]]; then
  _docker_compose_installed=true
  echo "Found Docker Compose"
else
  echo "Docker Compose Not Found"
fi

which -s docker-machine
if [[ $? == 0 ]]; then
  _docker_has_machine_installed=true
  echo "Found Docker Machine"
else
  echo "Docker Machine Not Found"
fi

function install_docker() {
  if [[ is_mac ]]; then
    # Make sure brew is installed on mac
    $brew

    if [[ "$_docker_installed" == false ]]; then
      brew install docker
    fi

    if [[ "$_docker_compose_installed" == false ]]; then
      brew install docker-compose
    fi

    if [[ "$_docker_machine_installed" == false ]]; then
      brew install docker-machine
    fi

  elif [[ is_linux ]]; then
    if [[ "$_docker_installed" == false ]]; then
      echo "Updating Docker Repositories"
      sudo apt-get update
      sudo apt-get install \
            apt-transport-https \
            ca-certificates \
            curl \
            software-properties-common
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
      sudo apt-key fingerprint 0EBFCD88
      sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

      echo "Installing Docker"
      sudo apt-get update
      sudo apt-get install docker-ce
    fi

    if [[ "$_docker_compose_installed" == false ]]; then
      echo "Installing Docker Compose"
      sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
      sudo chmod +x /usr/local/bin/docker-compose
    fi
  fi
}

docker=install_docker



# *** DO NOT CHANGE HERE ***
# Source from: tools/java.sh
_java_installed=false
which -s java
if [[ $? == 0 ]]; then
  _java_has_installed=true
  echo "Found Java"
else
  _java_has_installed=false
  echo "Did not find Java"
fi

function install_brew() {
	if [[ "$_java_has_installed" == false ]]; then
		if [[ is_mac ]]; then
			$brew
			brew install java
		elif [[ is_linux ]]; then
      apt-get install -y default-jdk
		else
			echo "Unknown Platform"
			exit 1
		fi
		$_java_has_installed=true
	else
		echo "Already installed Java"
	fi
}

java=install_java



# *** DO NOT CHANGE HERE ***
# Source from: tools/jetbrains.sh
function install_jetbrains() {
  if [[ is_mac ]]; then
      $brew
      brew cask install intellij-idea-ce pycharm-idea-ce
  elif [[ is_linux ]]; then
      sudo snap install intellij-idea-ultimate --classic
  fi
}

jetbrains=install_jetbrains


# *** DO NOT CHANGE HERE ***
# Source from: tools/mas.sh
function install_mas() {
  if [[ is_mac ]]; then
    $brew
    brew install mas

    # App Store
    mas lucky Xcode
    mas lucky Slack
    mas lucky Caffeine

    mas lucky "Final Cut Pro"
    mas lucky "Compressor"
    mas lucky "Motion"
  fi
}
mas=install_mas


# *** DO NOT CHANGE HERE ***
# Source from: tools/maven.sh
_maven_installed=false
which -s mvn
if [[ $? == 0 ]]; then
  _maven_has_installed=true
  echo "Found Maven"
else
  _maven_has_installed=false
  echo "Did not find Maven"
fi

function install_maven() {
	if [[ "$_java_has_installed" == false ]]; then
    $brew
	  $java
		if [[ is_mac ]]; then
			brew install maven
		elif [[ is_linux ]]; then
      apt-get install -y maven
		else
			echo "Unknown Platform"
			exit 1
		fi
		_maven_has_installed=true
	else
		echo "Already installed Maven"
	fi
}

maven=install_maven
mvn=install_maven


# *** DO NOT CHANGE HERE ***
# Source from: tools/python.sh
_python_installed=false
_pip_installed=false
_pip_deps_updated=false

which -s python3
if [[ $? == 0 ]]; then
  _python_installed=true
  echo "Found Python3"
else
  echo "Python3 Not Found"
fi

which -s pip3
if [[ $? == 0 ]]; then
  _pip_installed=true
  echo "Found pip3"
else
  echo "Pip3 Not Found"
fi

function install_python() {
  if [[ is_mac ]]; then
      $brew
      if [[ "$_python_installed" == false ]]; then
        brew install python3
        _python_installed=true
      else
        brew update python3
      fi
  elif [[ is_linux ]]; then
    if [[ "$_python_installed" == false ]]; then
      sudo apt-get install python3-pip
      _python_installed=true
    fi
  fi

  if [[ "$_pip_installed" == false ]]; then
    # Pip3 install
    python3 get-pip.py
    _pip_installed=true
  fi

  if [[ "$_pip_deps_updated" == false ]]; then
    # Get pip dependencies
    pip3 install --update pip virtualenv

    $java

    # Data Science
    pip3 install --update pandas numpy tensorflow scikit-learn pyspark

    # Ops
    pip3 install --update docker
  fi
}
python=install_python


# *** DO NOT CHANGE HERE ***
# Source from: tools/swift.sh
_SWIFT_VERSION=4.2.1
_SWIFT_FLAVOUR=RELEASE

_swift_installed=false
which -s swift
if [[ $? == 0 ]]; then
  _swift_installed=true
  echo "Found Swift"
else
  echo "Swift Not Found"
fi

function install_swift() {
  if [[ is_linux ]]; then
    if [[ "$_swift_installed" == false ]]; then
      $python

      echo "deb http://bg.archive.ubuntu.com/ubuntu/ trusty-security main" >> /etc/apt/sources.list
      echo "deb-src http://bg.archive.ubuntu.com/ubuntu/ trusty-updates main" >> /etc/apt/sources.list

      CURL_PACKAGE=$(apt search libcurl | grep "^libcurl[0-9]/"|  sed -e "/libcurl[0-9]/q" | cut -d'/' -f 1)

      # basic dependencies
      apt-get update && \
          sudo apt-get install -y git python3-pip cmake wget git build-essential

      # swift
      UBUNTU_VERSION=$(lsb_release -r | awk '{print $2}')
      echo "Ubuntu Version: $UBUNTU_VERSION"

      wget https://swift.org/builds/swift-${_SWIFT_VERSION}-release/ubuntu$(echo $UBUNTU_VERSION | sed 's/\.//g')/swift-${_SWIFT_VERSION}-${_SWIFT_FLAVOUR}/swift-${_SWIFT_VERSION}-${_SWIFT_FLAVOUR}-ubuntu${UBUNTU_VERSION}.tar.gz

      # Swift dependencies
      sudo apt-get -y install clang libicu-dev libpython2.7 CURL_PACKAGE
      wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import -

      gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift
      rm -rf ~/.swift
      mkdir ~/.swift
      tar xzf swift-${_SWIFT_VERSION}-${_SWIFT_FLAVOUR}-ubuntu${UBUNTU_VERSION}.tar.gz --strip-components 1 -C ~/.swift
      echo "export PATH=~/.swift/usr/bin:$PATH" >> ~/.bash_profile

      source ~/.bash_profile
      _swift_installed=true
    fi
  fi
}
swift=install_swift


# *** DO NOT CHANGE HERE ***
# Source from: tools/swig.sh
function install_swig() {
  if [[ is_mac ]]; then
      # Do something under Mac OS X platform
      $brew
      brew install swig
  elif [[ is_linux ]]; then
      # Do something under GNU/Linux platform
      sudo apt-get install swig
  fi
}
swig=install_swig


# *** DO NOT CHANGE HERE ***
# Source from: tools/vim.sh
_vim_installed=false

which -s vim
if [[ $? == 0 ]]; then
  _vim_installed=true
  echo "Found VIM"
else
  echo "Vim Not Found"
fi

function install_vim() {
  $python
  if [[ "$_vim_installed" == false ]]; then
    sudo apt-get install -y vim
    _vim_installed=true
  fi

  # Setup VIM
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  curl $BASE_URL/tools/vimrc -o ~/.vimrc
  source ~/.vimrc
  vim +PluginInstall +qall

  # Install YouComplteMe
  cd ~/.vim/bundle/YouCompleteMe
  python3 install.py --clang-completer
}
vim=install_vim


# *** DO NOT CHANGE HERE ***
# Source from: cpp/grpc.sh
function install_grpc() {
  GRPC_RELEASE_TAG=v1.22.0

  command -v make >/dev/null 2>&1 || { echo >&2 "I require make but it's not installed.  Aborting."; exit 1; }
  command -v git >/dev/null 2>&1 || { echo >&2 "I require git but it's not installed.  Aborting."; exit 1; }
  command -v ldconfig >/dev/null 2>&1 || { echo >&2 "I require ldconfig but it's not installed.  Aborting."; exit 1; }

  echo '-- fetching grpc -- '
  git clone -b ${GRPC_RELEASE_TAG} https://github.com/grpc/grpc /var/local/git/grpc && \
    cd /var/local/git/grpc && \
    git submodule update --init --recursive

  echo '-- installing protobuf' && \
    cd /var/local/git/grpc/third_party/protobuf && \
    ./autogen.sh && ./configure --enable-shared && \
    make -j$(nproc) && make -j$(nproc) check && make install && make clean && ldconfig

  echo "-- installing grpc" && \
    cd /var/local/git/grpc && \
    make -j$(nproc) && make install && make clean && ldconfig
}
grpc=install_grpc


# *** DO NOT CHANGE HERE ***
# Source from: platforms/mac.sh
function install_mac() {
  if [[ is_mac ]]; then
    $brew

    # Cask install
    brew install cask watch watchman cmake boost catch2 npm yarn

    sudo gem install cocoapods
  fi
}
mac=install_mac


# *** DO NOT CHANGE HERE ***
# Source from: platforms/ubuntu.sh
function install_ubuntu() {
  if [[ is_linux ]]; then
    sudo apt-get update -y && sudo apt-get install -y git cmake catch libboost-all-dev build-essential
  fi
}
ubuntu=install_ubuntu


# *** DO NOT CHANGE HERE ***
# Source from: platforms/init.sh
echo "-- Initialiazing platform"
if [[ is_mac ]]; then
  $mac
elif [[ is_linux ]]; then
  $ubuntu
fi

echo "-- Running Main"
_found_help=false
_found_file=false
_file=""

_is_next_file=false
for arg in "$@"
do
    if [ "$arg" == "--help" ] || [ "$arg" == "-h" ]
    then
        _found_help=true
    fi

    if [ "$arg" == "--file" ] || [ "$arg" == "-f" ]
    then
      if [ "$_found_file" == false ]
      then
        _is_next_file=true
      else
        echo "Only one file allowed. See --help for more info."
        exit 1
      fi
    fi

    if [ "$_is_next_file" == true ]
    then
      _file="$arg"
      _is_next_file=false
      if [[ -f "$_file" ]]; then
        _found_file=true
      else
        echo "Input file not found: $arg"
        exit 1
      fi
    fi
done

if [[ "$_found_file" == true ]]
then
  echo "-- Processing input file"
  while IFS= read -r line
  do
    echo "Installing: $line"
    ${line}
  done < "$_file"
else
  echo "-- Processing from args"
  for arg in "$@"
  do
    echo "Installing: $arg"
    ${arg}
  done
fi
echo "-- Finished processing"