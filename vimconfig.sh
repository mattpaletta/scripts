set -e

# Setup VIM
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
curl https://raw.githubusercontent.com/mattpaletta/scripts/master/vimrc -o ~/.vimrc
source ~/.vimrc
vim +PluginInstall +qall
