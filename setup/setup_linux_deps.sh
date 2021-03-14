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
  if [ $? -ne 0 ]; then
    echo "$0"
    echo 'setting up linux deps as root did not work out...'
    exit 1
  fi
  sudo apt install -y libssl-dev
  sudo apt install -y curl
  sudo apt install -y tree
  sudo apt install -y build-essential
  sudo apt install -y neovim
  sudo apt install -y fish
  sudo apt install -y python3
  sudo apt install -y python3-pip
  sudo apt install -y silversearcher-ag
  sudo python3 -m pip install --upgrade pip
  sudo python3 -m pip install virtualenv
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
  sudo apt install -y libssl-dev
  sudo apt install -y curl
  sudo apt install -y tree
  sudo apt install -y build-essential
  sudo apt install -y fish
  sudo apt install -y python3
  sudo apt install -y python3-pip
  sudo apt install -y silversearcher-ag
  sudo python3 -m pip install --upgrade pip
  sudo python3 -m pip install virtualenv
fi

echo 'done installing linux depenencies'

