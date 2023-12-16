#!/bin/bash

echo "$0"

if [ `uname` != 'Linux' ]; then
  echo 'I only run on Linux..'
  exit 1
fi

echo 'setting up linux dependencies (apt/python)'

if [[ $EUID -eq 0 ]]; then
  echo 'need root password to install linux dependencies..'
  sudo apt update
  sudo apt -y upgrade
  if [ $? -ne 0 ]; then
    echo "$0"
    echo 'setting up linux deps as root did not work out...'
    exit 1
  fi
  sudo apt install -y build-essential libssl-dev curl tree zsh python3 silversearcher-ag python3-pip
fi

if [[ $EUID -ne 0 ]]; then
  # regular joe attempt
  echo 'need root password to install linux dependencies..'
  sudo apt update
  if [ $? -ne 0 ]; then
    echo "$0"
    echo 'setting up linux deps as root did not work out...'
    exit 1
  fi
  sudo apt install -y build-essential libssl-dev curl tree zsh python3 silversearcher-ag python3-pip
fi

echo 'done installing linux depenencies'
