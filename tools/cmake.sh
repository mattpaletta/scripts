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
