#!/bin/bash

echo "$0"

if [ `uname` != 'Linux' ]; then
  echo 'I only run on Linux..'
  exit 1
fi

echo "setting up locale"
sudo locale-gen "en_US.UTF-8"

echo 'setting up linux dependencies (apt/python)'

sudo apt update
sudo apt -y upgrade
sudo apt install -y build-essential libssl-dev curl tree zsh python3 python3-pip fd-find unzip

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

echo "Activating NVM"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "Installing latest node version"

if type nvm > /dev/null 2>&1; then
    echo "NVM found. Installing Node.js..."
    nvm install node
    echo "installing npm packages......."
    npm install lua-fmt prettier jsonlint -g
else
    echo "NVM not found. Skipping Node.js installation."
fi
