#!/bin/bash
sudo apt update && sudo apt install -y neovim curl

git clone https://github.com/ono7/dotfiles2.git ~/.dotfiles

source ~/.dotfiles/setup_shell_scripts/setup_dirs.sh
