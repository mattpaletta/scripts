function install_mac() {
  if [[ is_mac ]]; then
    $brew

    # Cask install
    brew install cask watch watchman cmake boost catch2 npm yarn

    sudo gem install cocoapods
  fi
}
mac=install_mac