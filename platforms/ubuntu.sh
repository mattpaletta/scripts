#!/bin/bash
set -e
./constants.sh

sudo apt-get update -y && sudo apt-get install -y git

declare -a TOOLS=("swift" "python" "vim" "jetbrains" "docker" "swig")
run_tools TOOLS