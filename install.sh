#!/usr/bin/env sh
./constants.sh

if [[ is_mac ]]; then
    # Do something under Mac OS X platform
    run_platform "mac"
elif [[ is_linux ]]; then
    # Do something under GNU/Linux platform
    run_platform "ubuntu"
fi