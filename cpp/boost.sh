function install_boost() {
  BOOST_RELEASE_TAG=1.71

  command -v make >/dev/null 2>&1 || { echo >&2 "I require make but it's not installed.  Aborting."; exit 1; }
  command -v git >/dev/null 2>&1 || { echo >&2 "I require git but it's not installed.  Aborting."; exit 1; }
  command -v ldconfig >/dev/null 2>&1 || { echo >&2 "I require ldconfig but it's not installed.  Aborting."; exit 1; }

  wget https://dl.bintray.com/boostorg/release/1.71.0/source/boost_1_71_0.tar.bz2
  tar --bzip2 -xf boost_1_71_0.tar.bz2
  cd boost_1_71_0
  ./bootstrap.sh --with-libraries=all
  ./b2 install
}
boost=install_boost
