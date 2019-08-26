_docker_installed=false
_docker_compose_installed=false
_docker_has_machine_installed=false

command -v docker
if [[ $? == 0 ]]; then
  _docker_installed=true
  echo "Found Docker"
else
  echo "Docker Not Found"
fi

command -v docker-compose
if [[ $? == 0 ]]; then
  _docker_compose_installed=true
  echo "Found Docker Compose"
else
  echo "Docker Compose Not Found"
fi

command -v docker-machine
if [[ $? == 0 ]]; then
  _docker_has_machine_installed=true
  echo "Found Docker Machine"
else
  echo "Docker Machine Not Found"
fi

function install_docker() {
  if [[ $is_mac == 0 ]]; then
    # Make sure brew is installed on mac
    $brew

    if [[ "$_docker_installed" == false ]]; then
      brew install docker
    fi

    if [[ "$_docker_compose_installed" == false ]]; then
      brew install docker-compose
    fi

    if [[ "$_docker_machine_installed" == false ]]; then
      brew install docker-machine
    fi

  elif [[ $is_linux == 0 ]]; then
    if [[ "$_docker_installed" == false ]]; then
      echo "Updating Docker Repositories"
      apt-get -qq update -y
      apt-get -qq install -y \
            apt-transport-https \
            ca-certificates \
            curl \
            software-properties-common
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
      apt-key fingerprint 0EBFCD88
      add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

      echo "Installing Docker"
      apt-get -qq update -y
      apt-get -qq install -y docker-ce
    fi

    if [[ "$_docker_compose_installed" == false ]]; then
      echo "Installing Docker Compose"
      curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
      chmod +x /usr/local/bin/docker-compose
    fi
  fi
}

docker=install_docker
