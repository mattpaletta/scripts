_vim_installed=false

command -v vim
if [[ $? == 0 ]]; then
  _vim_installed=true
  echo "Found VIM"
else
  echo "Vim Not Found"
fi

function install_vim() {
  $cmake
  $python
  if [[ "$_vim_installed" == false ]]; then
    apt-get -qq install -y vim
    _vim_installed=true
  fi

  # Setup VIM
  apt-get -qq install -y git curl
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  curl $BASE_URL/tools/vimrc -o ~/.vimrc
  #source ~/.vimrc
  vim +PluginInstall +qall

  # Install YouComplteMe
  pushd ~/.vim/bundle/YouCompleteMe
  python3 install.py --clang-completer
  popd
}
vim=install_vim