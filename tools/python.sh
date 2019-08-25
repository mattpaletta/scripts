_python_installed=false
_pip_installed=false
_pip_deps_updated=false

which -s python3
if [[ $? == 0 ]]; then
  _python_installed=true
  echo "Found Python3"
else
  echo "Python3 Not Found"
fi

which -s pip3
if [[ $? == 0 ]]; then
  _pip_installed=true
  echo "Found pip3"
else
  echo "Pip3 Not Found"
fi

function install_python() {
  if [[ is_mac ]]; then
      $brew
      if [[ "$_python_installed" == false ]]; then
        brew install python3
        _python_installed=true
      else
        brew update python3
      fi
  elif [[ is_linux ]]; then
    if [[ "$_python_installed" == false ]]; then
      sudo apt-get install python3-pip
      _python_installed=true
    fi
  fi

  if [[ "$_pip_installed" == false ]]; then
    # Pip3 install
    python3 get-pip.py
    _pip_installed=true
  fi

  if [[ "$_pip_deps_updated" == false ]]; then
    # Get pip dependencies
    pip3 install --update pip virtualenv

    $java

    # Data Science
    pip3 install --update pandas numpy tensorflow scikit-learn pyspark

    # Ops
    pip3 install --update docker
  fi
}
python=install_python