#!/bin/bash
# installs files for work machines which use workspace idea.
cd ~/
if [ ! -d ~/git-scripts ]; then
  git clone git@bitbucket.org:corsoa/git-scripts.git
fi
bash git-scripts/set_sym_links.sh ~/workspace
if [ ! -d ~/work_dotfiles ]; then
  git clone git@bitbucket.org:corsoa/work_dotfiles.git
fi
for f in $(ls -d ~/work_dotfiles/.*); do
  ln -fs $f ~/;
done
