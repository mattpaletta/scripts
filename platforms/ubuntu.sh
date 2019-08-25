function install_ubuntu() {
  if [[ is_linux ]]; then
    sudo apt-get update -y && sudo apt-get install -y git cmake catch libboost-all-dev build-essential
  fi
}
ubuntu=install_ubuntu