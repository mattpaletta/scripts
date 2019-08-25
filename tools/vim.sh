_vim_installed=false

which -s vim
if [[ $? == 0 ]]; then
  _vim_installed=true
  echo "Found VIM"
else
  echo "Vim Not Found"
fi

function install_vim() {
  $python
  if [[ "$_vim_installed" == false ]]; then
    sudo apt-get install -y vim
    _vim_installed=true
  fi

  # Setup VIM
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  curl $BASE_URL/tools/vimrc -o ~/.vimrc
  source ~/.vimrc
  vim +PluginInstall +qall

  # Install YouComplteMe
  cd ~/.vim/bundle/YouCompleteMe
  python3 install.py --clang-completer
}
vim=install_vim