# .bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

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

# User specific aliases and functions

alias gitlog="git log --oneline --abbrev-commit --all --graph --decorate --color"
alias sourceme="source ~/.bashrc"
alias ..="cd ../"
alias ..2="cd ../../"
alias ..3="cd ../../../"
alias ..4="cd ../../../../"
alias ssh='ssh -o ServerAliveInterval=30 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no '
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias tmux="tmux -2" 
alias joinme="tmux attach-session -t aaron"
alias leave="tmux detach"

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# display directories in green
LS_COLORS="ow=01;92:di=01;92"
export LS_COLORS
alias ls='ls --color=always'
alias ll='ls -la | more'

# The colors that the prompt uses
BLUE="\[\033[0;34m\]"
RED="\[\033[0;31m\]"
LIGHT_RED="\[\033[1;31m\]"
GREEN="\[\033[0;32m\]"
LIGHT_GREEN="\[\033[1;32m\]"
WHITE="\[\033[1;37m\]"
LIGHT_GRAY="\[\033[0;37m\]"

export TERM="xterm-256color"

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

#alias vi=vim
PATH=${HOME}/bin:${PATH}

# Note: ~/.ssh/environment should not be used, as it
#       already has a different purpose in SSH.

env=~/.ssh/agent.env

# Note: Don't bother checking SSH_AGENT_PID. It's not used
#       by SSH itself, and it might even be incorrect
#       (for example, when using agent-forwarding over SSH).

agent_is_running() {
    if [ "$SSH_AUTH_SOCK" ]; then
        # ssh-add returns:
        #   0 = agent running, has keys
        #   1 = agent running, no keys
        #   2 = agent not running
        ssh-add -l >/dev/null 2>&1 || [ $? -eq 1 ]
    else
        false
    fi
}

agent_has_keys() {
    ssh-add -l >/dev/null 2>&1
}

agent_load_env() {
    . "$env" >/dev/null
}

agent_start() {
    (umask 077; ssh-agent >"$env")
    . "$env" >/dev/null
}

if ! agent_is_running; then
    agent_load_env
fi

# if your keys are not stored in ~/.ssh/id_rsa or ~/.ssh/id_dsa, you'll need
# to paste the proper path after ssh-add
if ! agent_is_running; then
    agent_start
    ssh-add
elif ! agent_has_keys; then
    ssh-add
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
export PATH=$PATH:/usr/local/node/bin

export EDITOR="vim"
unset env

if [ -f "/home/$(whoami)/.machines" ]
  then
  source /home/$(whoami)/.machines
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [ -f "~/work.alises" ]
  then
  source ~/work.aliases
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/aaron/.sdkman"
[[ -s "/home/aaron/.sdkman/bin/sdkman-init.sh" ]] && source "/home/aaron/.sdkman/bin/sdkman-init.sh"
