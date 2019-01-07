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

if [[ is_mac ]]; then
    #brew cask install intellij-idea-ce pycharm-idea-ce
elif [[ is_linux ]]; then
    #sudo snap install intellij-idea-ultimate --classic
fi