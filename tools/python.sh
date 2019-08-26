_python_installed=false
_pip_installed=false
_pip_deps_updated=false

command -v python3
if [[ $? == 0 ]]; then
  _python_installed=true
  echo "Found Python3"
else
  echo "Python3 Not Found"
fi

command -v pip3
if [[ $? == 0 ]]; then
  _pip_installed=true
  echo "Found pip3"
else
  echo "Pip3 Not Found"
fi

function install_python() {
  if [[ $is_mac == 0 ]]; then
      $brew
      if [[ "$_python_installed" == false ]]; then
        brew install python3
        _python_installed=true
      else
        brew update python3
      fi
  elif [[ $is_linux == 0 ]]; then
    if [[ "$_python_installed" == false ]]; then
      apt-get -qq install -y python3-pip
      _python_installed=true
    fi
  fi

  if [[ "$_pip_installed" == false ]]
  then
    apt-get -qq install -y curl
    curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
    # Pip3 install
    python3 get-pip.py
    rm get-pip.py

    _pip_installed=true
  fi

  if [[ "$_pip_deps_updated" == false ]]; then
    # Get pip dependencies
    pip3 install pip virtualenv

    pip3 install requests Pillow

    $java

    # Data Science
    pip3 install pandas numpy tensorflow scikit-learn Scipy pyspark

    # Ops
    pip3 install docker
  fi
}
python=install_python