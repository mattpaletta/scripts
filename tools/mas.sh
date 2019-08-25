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