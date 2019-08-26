function install_jetbrains() {
  if [[ $is_mac == 0 ]]; then
      $brew
      brew cask install intellij-idea-ce pycharm-idea-ce
  elif [[ $is_linux == 0 ]]; then
      snap install intellij-idea-ultimate --classic
  fi
}

jetbrains=install_jetbrains