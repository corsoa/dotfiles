# .bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth
export HISTFILE="$HOME/.bash_history"
# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# look for, and enable, command-not-found
[ -f /usr/share/doc/pkgfile/command-not-found.bash ] && . /usr/share/doc/pkgfile/command-not-found.bash

# set env vars for prompt addons
export ENHANCED_PROMPT=true
export GIT_PROMPT_ON=true
export GIT_PROMPT_DETAILED=true

# load prompt addons
[ -f ~/.git-completion ] && . ~/.git-completion
[ -f ~/.promptrc ] && . ~/.promptrc

# enable bash-completion if it exists
if [ -f /etc/bash_completion ]
then
	. /etc/bash_completion
elif [ -f /usr/share/bash-completion/bash_completion ]
then
	. /usr/share/bash-completion/bash_completion
elif which brew &>/dev/null && [ -f $(brew --prefix)/etc/bash_completion ]
then
	. $(brew --prefix)/etc/bash_completion
fi

export EDITOR="vim"
# display directories in green
LS_COLORS="ow=01;92:di=01;92"
export LS_COLORS

# The colors that the prompt uses
BLUE="\[\033[0;34m\]"
RED="\[\033[0;31m\]"
LIGHT_RED="\[\033[1;31m\]"
GREEN="\[\033[0;32m\]"
LIGHT_GREEN="\[\033[1;32m\]"
WHITE="\[\033[1;37m\]"
LIGHT_GRAY="\[\033[0;37m\]"

export TERM="xterm-256color"
export LC_ALL="en_US.UTF-8"
export LANG='en_US.UTF-8'

# Show user name
function __prompt_username {
    # echo -n "$(whoami)"
    echo -n "$(whoami)"
}

# Show host name
function __prompt_hostname {
  echo -n "$(hostname)"
}


# Show current directory
function __prompt_pwd {
    echo "$(pwd)"
}

function git_diff() {
  git diff --no-ext-diff -w "$@" | vim -R –
}

function __prompt_git_branch {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        return 0
    fi

    git_branch=$(git branch 2> /dev/null | sed -n '/^\*/s/^\* //p')
    if git diff HEAD --quiet 2> /dev/null >&2; then
        git_color="$GREEN"
    else
        git_color="$RED"
    fi

    echo " ($git_branch)"
}

# Prompt output function
function proml {
  # The colors that the prompt uses
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  local       RESET="\[\e[00m\]"
  local  LIGHT_BLUE="\[\033[0;94m\]"

# And finally, set the prompt
PS1="\
$GREEN\$(__prompt_username)\
$GREEN@\
$(__prompt_hostname)\
$LIGHT_BLUE\$(__prompt_git_branch)\
$GREEN \$(__prompt_pwd)\n#\
$RESET"
PS2='> '
PS4='+ '
}
#source ~/perl5/perlbrew/etc/bashrc
# Execute the prompt function
proml

PATH=${HOME}/bin:${PATH}
# Note: ~/.ssh/environment should not be used, as it
#       already has a different purpose in SSH.
if [ -f ~/.ssh_load ]; then
    source ~/.ssh_load
fi

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

if [ -f ~/.machines ]; then
  source ~/.machines
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [ -f ~/.work_aliases ]; then
  source ~/.work_aliases
fi

if [ -f ~/.work_machines ]; then
  source ~/.work_machines
fi

if [ -f ~/.exports ]; then
    source ~/.exports
fi

if [ -f ~/.work_exports ]; then
    source ~/.work_exports
fi
unset env

