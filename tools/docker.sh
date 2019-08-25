_docker_installed=false
_docker_compose_installed=false
_docker_has_machine_installed=false

which -s docker
if [[ $? == 0 ]]; then
  _docker_installed=true
  echo "Found Docker"
else
  echo "Docker Not Found"
fi

which -s docker-compose
if [[ $? == 0 ]]; then
  _docker_compose_installed=true
  echo "Found Docker Compose"
else
  echo "Docker Compose Not Found"
fi

which -s docker-machine
if [[ $? == 0 ]]; then
  _docker_has_machine_installed=true
  echo "Found Docker Machine"
else
  echo "Docker Machine Not Found"
fi

function install_docker() {
  if [[ is_mac ]]; then
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

  elif [[ is_linux ]]; then
    if [[ "$_docker_installed" == false ]]; then
      echo "Updating Docker Repositories"
      sudo apt-get update
      sudo apt-get install \
            apt-transport-https \
            ca-certificates \
            curl \
            software-properties-common
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
      sudo apt-key fingerprint 0EBFCD88
      sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

      echo "Installing Docker"
      sudo apt-get update
      sudo apt-get install docker-ce
    fi

    if [[ "$_docker_compose_installed" == false ]]; then
      echo "Installing Docker Compose"
      sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
      sudo chmod +x /usr/local/bin/docker-compose
    fi
  fi
}

docker=install_docker
