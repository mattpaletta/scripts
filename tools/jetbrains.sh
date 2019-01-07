#!/bin/bash
set -e
../constants.sh

if [[ is_mac ]]; then
    #brew cask install intellij-idea-ce pycharm-idea-ce
elif [[ is_linux ]]; then
    #sudo snap install intellij-idea-ultimate --classic
fi