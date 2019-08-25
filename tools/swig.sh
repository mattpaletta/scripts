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