#!/bin/bash

echo "$0"

. ./setup_omzsh.sh

if [ $(which zsh) ]; then
  chsh -s $(which zsh)
  if [ $? -eq 0 ]; then
    echo 'change shell seems to have worked!'
  else
    echo "$0"
    echo 'unable to set default shell to zsh'
    exit 1;
  fi
fi
