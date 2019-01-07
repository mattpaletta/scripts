#!/usr/bin/env sh
../constants.sh

if [[ is_mac ]]; then
    # Install Brew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    # Add Command Line Tools
    xcode-select --install
elif [[ is_linux ]]; then
    # Do something under GNU/Linux platform
    # TODO Add brew for linux
fi