#!/bin/env bash

function test_mac() {
    echo "Checking if mac"
    command -v uname
    if [[ $? == 0 ]]
    then
      if [[ "$(uname)" == "Darwin" ]]
      then
        return 0
      fi
    fi
    return 1
}

function test_linux() {
    echo "Checking if linux"
    command -v apt
    if [[ $? == 0 ]]
    then
      linux_ver="$(cat /etc/os-release | grep "ID=[a-z]")"
      echo $linux_ver
      if [[ "$linux_ver" == "ID=ubuntu" ]]
      then
        echo "Found Ubuntu"
        return 0
      else
        echo "Did not find Ubuntu"
        return 1
      fi
    else
      echo "Apt not installed"
      # apt not installed, so can't be linux
      return 1
    fi
}

test_linux
is_linux=$?

test_mac
is_mac=$?

BASE_URL="https://raw.githubusercontent.com/mattpaletta/scripts/master"

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
