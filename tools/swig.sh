function install_swig() {
  if [[ $is_mac == 0 ]]; then
      # Do something under Mac OS X platform
      $brew
      brew install swig
  elif [[ $is_linux == 0 ]]; then
      # Do something under GNU/Linux platform
      apt-get -qq install -y swig
  fi
}
swig=install_swig