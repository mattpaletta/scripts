#!/usr/bin/env bash
../constants.sh

if [[ is_mac ]]; then
    # Do something under Mac OS X platform        
    brew install swig
elif [[ is_linux ]]; then
    # Do something under GNU/Linux platform
    sudo apt-get install swig
fi
