set -e

# Install Brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Cask install
brew install cask watch watchman cmake

# Setup Vim
curl https://raw.githubusercontent.com/mattpaletta/scripts/master/vimconfig.sh | sh

# Configure Mas
curl https://raw.githubusercontent.com/mattpaletta/scripts/master/mas.sh | sh

# Configure Docker
curl https://raw.githubusercontent.com/mattpaletta/scripts/master/docker.sh | sh

# Jetbrains
curl https://raw.githubusercontent.com/mattpaletta/scripts/master/jetbrains.sh | sh


# Python 3
curl https://raw.githubusercontent.com/mattpaletta/scripts/master/python.sh | sh
