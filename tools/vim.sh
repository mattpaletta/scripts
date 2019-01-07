#!/usr/bin/env sh
set -e

if [[ is_linux ]]; then
    sudo apt-get update && sudo apt-get install -y vim
fi

# Setup VIM
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
curl https://raw.githubusercontent.com/mattpaletta/scripts/master/tools/vimrc -o ~/.vimrc
source ~/.vimrc
vim +PluginInstall +qall
