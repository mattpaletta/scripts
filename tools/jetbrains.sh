function install_jetbrains() {
  if [[ is_mac ]]; then
      $brew
      brew cask install intellij-idea-ce pycharm-idea-ce
  elif [[ is_linux ]]; then
      sudo snap install intellij-idea-ultimate --classic
  fi
}

jetbrains=install_jetbrains