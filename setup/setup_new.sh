#!/bin/bash

echo "$0"

cd ~/.dotfiles/setup

. ./setup_dirs.sh

# setup dirs and symlinks
# if [ ! -d ~/.config/nvim ]; then
#   . ./setup_dirs.sh
# else
#   echo 'directory structure already set.. skipping..'
# fi

# whats your flavor today?
if [ `uname` == 'Darwin' ]; then
  echo 'Setting up MacOS.. make sure you have sudo! or exit'
  cd ~/.dotfiles/setup
  . ./setup_macos_user_settings.sh
  cd ~/.dotfiles/setup
  . ./setup_macos_deps.sh
  if [ $? -ne 0 ]; then
    echo "$0"
    echo 'setting up dependencies failed...'
  fi
else
  echo 'Setting up Linux.. make sure you have sudo! or exit'
  cd ~/.dotfiles/setup
  . ./setup_linux_deps.sh
  if [ $? -ne 0 ]; then
    echo "$0"
    echo 'setting up dependencies failed...'
  fi
fi

# setup virtualenv
cd ~/.dotfiles/setup
. ./setup_virtualenv.sh

# setup vim
cd ~/.dotfiles/setup
. ./setup_neovim.sh

# setup tmux
cd ~/.dotfiles/setup
. ./setup_tmux.sh

# change default shell
# cd ~/.dotfiles/setup
# . ./setup_chsh_fish.sh
