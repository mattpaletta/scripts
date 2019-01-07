#!/bin/bash
set -e
../constants.sh

# This needs to run first!
run_tool brew

# Cask install
brew install --upgrade cask
brew install --upgrade watch 
brew install --upgrade watchman 
brew install --upgrade cmake

declare -a TOOLS=("python" "vim" "jetbrains" "docker" "swig" "mas")
run_tools TOOLS

sudo gem install cocoapods