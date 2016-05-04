#!/bin/bash
command_exists () {
    type "$1" &> /dev/null ;
}
if command_exists yum ; then
    yum install zsh tmux
elif command_exists apt-get ; then
    apt-get install zsh tmux
fi
sh -c "$(wget --no-check-certificate https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
shopt -s dotglob
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
for f in $DIR/*; do
    if [ $(basename $f) != ".git" ] 
    then
        ln -fs $DIR/$(basename $f) ~/$(basename $f)
    fi
done
ln -fs /usr/bin/vim /usr/bin/vi
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall
#reload tmux conf in case we're already in a tmux session
tmux source-file ~/.tmux.conf
