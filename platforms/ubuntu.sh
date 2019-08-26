function install_ubuntu() {
  if [[ $is_linux == 0 ]]
  then
      echo "Initializing Ubuntu"
      apt-get -qq update -y
      apt-get -qq install -y git cmake curl wget catch libboost-all-dev build-essential
  fi
}
ubuntu=install_ubuntu