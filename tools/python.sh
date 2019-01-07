#!/usr/bin/env sh
set -e
../constants.sh

if [[ is_mac ]]; then
    brew install python3
elif [[ is_linux ]]; then
    sudo apt-get install python3-pip
fi

# Pip3 install
python3 get-pip.py

# Get pip dependencies
pip3 install virtualenv

# Data Science
pip3 install pandas numpy tensorflow scikit-learn pyspark

# Ops
pip3 install docker