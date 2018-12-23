set -e

# Install Brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Cask install
brew install cask watch watchman python3 cmake # mas

# Setup VIM
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
curl https://raw.githubusercontent.com/mattpaletta/scripts/master/vimrc -o ~/.vimrc
source ~/.vimrc
vim +PluginInstall +qall

# App Store
# mas lucky Xcode
# mas lucky Final\ Cut\ Pro\ X

# Install docker?
# brew install docker docker-compose docker-machine xhyve docker-machine-driver-xhyve
# sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
# sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
# docker-machine create default --driver xhyve --xhyve-experimental-nfs-share

# Jetbrains
# brew cask install intellij-idea-ce pycharm-idea-ce

# Pip3 install
python3 get-pip.py

# Get pip dependencies
pip3 install virtualenv
