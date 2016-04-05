#!/bin/bash
shopt -s dotglob
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
for f in $DIR/*; do
    if [ $(basename $f) != ".git" ] 
    then
        ln -fs $DIR/$(basename $f) ~/$(basename $f)
    fi
done
