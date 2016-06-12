#!/bin/bash
command_exists () {
    type "$1" &> /dev/null ;
}

#install and change shell to zsh if not already
if ! command_exists zsh
then
    if command_exists yum ; then
        sudo yum install zsh tmux
    elif command_exists apt-get ; then
        sudo apt-get install zsh tmux
    fi
fi
if [ ! -d ~/.oh-my-zsh ]; then
    echo "ZSH NOT INSTALLED"
    sh -c "$(wget --no-check-certificate https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then 
    echo "SYNTAX NOT INSTALLED"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

#command line tools
if ! command_exists pip; then
    wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py
    sudo python get-pip.py
fi
if ! command_exists fpp ; then
    git clone https://github.com/facebook/pathpicker.git
    cd PathPicker
    ln -fs "$(pwd)/fpp" /usr/local/bin/fpp
fi

shopt -s dotglob
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
for f in $DIR/*; do
    if [ $(basename $f) != ".git" ] 
    then
        ln -fs $DIR/$(basename $f) ~/$(basename $f)
    fi
done

#do git diffs with vim
sudo ln -fs $DIR/git_diff_wrapper /usr/bin/git_diff_wrapper 

#reassign vi to vim
sudo ln -fs /usr/bin/vim /usr/bin/vi

#do a vundle install
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

vim +PluginInstall +qall

#reload tmux conf in case we're already in a tmux session
tmux source-file ~/.tmux.conf
