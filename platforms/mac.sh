function install_mac() {
  if [[ $is_mac == 0 ]]; then
    $brew

    # Cask install
    brew install cask watch watchman cmake boost catch2 npm yarn

    gem install cocoapods
  fi
}
mac=install_mac