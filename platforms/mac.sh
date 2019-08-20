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

# This needs to run first!
run_tool brew

# Cask install
brew install --upgrade cask watch watchman cmake boost catch2 npm yarn

declare -a TOOLS=("python" "vim" "jetbrains" "docker" "swig" "mas")
run_tools TOOLS

sudo gem install cocoapods