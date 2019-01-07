#!/bin/bash
set -e

is_mac() {
    return "$(uname)" == "Darwin"
}

is_linux() {
    return "$(expr substr $(uname -s) 1 5)" == "Linux"
}

BASE_URL="https://raw.githubusercontent.com/mattpaletta/scripts/master/"

exec_script() {
    curl $1 | sh
}

run_platform() {
    exec_script ${BASE_URL}/platform/$1.sh
}

run_tool() {
    exec_script ${BASE_URL}/tools/$1.sh
}

run_tools() {
    for script in $1
    do
        echo "Installing ${script}"
        run_tool ${script}
    done
}

if [[ is_linux ]]; then
    sudo apt-get update && sudo apt-get install -y vim
fi

# Setup VIM
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
curl https://raw.githubusercontent.com/mattpaletta/scripts/master/tools/vimrc -o ~/.vimrc
source ~/.vimrc
vim +PluginInstall +qall
