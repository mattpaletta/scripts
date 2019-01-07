set -e

if [ "$(uname)" == "Darwin" ]; then
	# install docker?
	brew install docker docker-compose docker-machine xhyve docker-machine-driver-xhyve
	sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
	sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
	docker-machine create default --driver xhyve --xhyve-experimental-nfs-share
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	echo "Updating Docker Repositories"
	sudo apt-get update
	sudo apt-get install \
    		apt-transport-https \
    		ca-certificates \
    		curl \
    		software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo apt-key fingerprint 0EBFCD88
	sudo add-apt-repository \
   		"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   		$(lsb_release -cs) \
   		stable"

	echo "Installing Docker"
	sudo apt-get update
	sudo apt-get install docker-ce

	echo "Installing Docker Compose"
	sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
fi
