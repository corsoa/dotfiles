#!/bin/bash
command_exists () {
	type "$1" &> /dev/null ;
}

install_if_not_exists () {
	if ! command_exists "$1"; then
		if command_exists yum ; then
			sudo yum -y install "$1"
		elif command_exists apt-get ; then
			sudo apt-get -y install "$1"
		fi
	fi
}

set_context () {
	#cd into the same directory where this script is located first so sym links are always correct
	shopt -s dotglob
	DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	cd $DIR
	for f in $DIR/*; do
		if [ $(basename $f) != ".git" ] && [ $(basename $f) != ".*" ]
		then
			ln -fs $DIR/$(basename $f) ~/$(basename $f)
		fi
	done
}

set_context

install_if_not_exists git
install_if_not_exists zsh
install_if_not_exists tmux
install_if_not_exists vim
install_if_not_exists reptyr

if [ ! -d ~/.oh-my-zsh ]; then
	sh -c "$(wget --no-check-certificate https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
fi

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

#python environment
if ! command_exists pyenv; then
	curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
  git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
fi
if ! command_exists pip; then
	wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py
	sudo python get-pip.py
fi
#command line tools
if ! command_exists fpp ; then
	if [ ! -d ~/.pathpicker ]; then
		git clone https://github.com/facebook/pathpicker.git ~/.pathpicker
		ln -fs ~/.pathpicker/fpp /usr/local/bin/fpp
		cd ../
	fi
fi

#do git diffs with vim
#sudo ln -fs $DIR/git_diff_wrapper /usr/bin/git_diff_wrapper

#reassign vi to vim
sudo ln -fs /usr/bin/vim /usr/bin/vi

#do a vim-plug install
if [ ! -f ~/.vim/autoload/plug.vim ]; then
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

vim +PlugInstall +qall

#install tpm if it's not there already
if [ ! -d ~/.tmux/plugins/tpm ]; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	~/.tmux/plugins/tpm/bin/install_plugins
fi

#todo: install nvm, pyenv by default

echo "changing shell"
# note: below did not work on systems like crostini where we don't have root password via prompt
# chsh -s $(which zsh)
sudo usermod -s $(which zsh) $(whoami)
source ~/.zshrc

#reload tmux conf in case we're already in a tmux session
if [ -n "$TMUX" ]; then
    tmux source-file ~/.tmux.conf
fi
