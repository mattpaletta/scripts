if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform        
    brew install swig
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Do something under GNU/Linux platform
    sudo apt-get install swig
fi
