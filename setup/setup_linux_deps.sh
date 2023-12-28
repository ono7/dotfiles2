#!/bin/bash

echo "$0"

if [ `uname` != 'Linux' ]; then
  echo 'I only run on Linux..'
  exit 1
fi

echo "setting up locale"
sudo locale-gen "en_US.UTF-8"

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
  sudo apt install -y build-essential libssl-dev curl tree zsh python3 silversearcher-ag python3-pip fd-find unzip
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
  sudo apt install -y build-essential libssl-dev curl tree zsh python3 silversearcher-ag python3-pip fd-find unzip
fi

echo 'done installing linux depenencies'

echo 'setting up nvim'

cd ~/
rm -rf ~/nvim
rm -rf ~/nvim-linux64
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar xzf nvim-linux64.tar.gz
mv nvim-linux64 nvim
rm nvim-linux64.tar.gz
ln -s ~/nvim/bin/nvim ~/local/bin/nvim
echo "Neovim setup for linux complete"


echo "install nvim...."

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
