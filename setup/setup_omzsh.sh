#!/bin/bash

if [ -d ~/.oh-my-zsh ]; then
  rm -rf ~/.oh-my-zsh
fi

echo 'closing oh-my-zsh'
echo ''
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo 'installing auto-suggestions for zsh'
echo ''
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

echo 'installing fzf-tab'
git clone https://github.com/Aloxaf/fzf-tab ~/.oh-my-zsh/custom/plugins/fzf-tab

echo 'setting up custom theme and linking zshrc'
echo ''
ln -sf ~/.dotfiles/zsh/avit.zsh-theme ~/.oh-my-zsh/custom/themes/
ln -sf ~/.dotfiles/zshrc_mac ~/.zshrc

echo 'changing shell...'
echo ''
if [ $(which zsh) ]; then
  chsh -s $(which zsh)
else
  echo 'missing zsh... lets install this first...'
fi
