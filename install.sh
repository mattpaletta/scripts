#!/bin/bash
curl https://raw.githubusercontent.com/mattpaletta/scripts/master/constants.sh | sh

if [[ is_mac ]]; then
    # Do something under Mac OS X platform
    run_platform "mac"
elif [[ is_linux ]]; then
    # Do something under GNU/Linux platform
    run_platform "ubuntu"
fi