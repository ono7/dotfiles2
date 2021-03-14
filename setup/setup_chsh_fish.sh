#!/bin/bash

echo "$0"

if [ $(which fish) ]; then
  chsh -s $(which fish)
  if [ $? -eq 0 ]; then
    echo 'change shell seems to have worked!'
  else
    echo "$0"
    echo 'unable to set default shell to fish'
  fi
fi
