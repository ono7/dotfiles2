#!/bin/bash
# baseline configuration
# Jose Lima
# 2019-02-07 10:22
# basic settings, just enough to get started

cd ~/.dotfiles/setup

echo "$0"

echo ################################################################################
echo #                            setting up directories                            #
echo ################################################################################

cd ~
mkdir -p ~/.tmp
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/kitty
mkdir -p ~/.tmux/plugins
mkdir -p ~/.ssh
mkdir -p ~/bin
mkdir -p ~/.npm-packages
mkdir -p ~/local
mkdir -p ~/.ctags.d/

echo ################################################################################
echo #                              creating symlinks                               #
echo ################################################################################

rm -rf ~/.vim
rm -rf ~/.config/nvim
mkdir -p ~/.vim/indent
ln -sf ~/.dotfiles/ctagsrc ~/.ctags.d/default.ctags
ln -sf ~/.dotfiles/mongorc.js ~/.mongorc.js
ln -sf ~/.dotfiles/mongorc.js ~/.mongoshrc.js
ln -sf ~/.dotfiles/ctagsrc ~/.ctags
ln -sf ~/.dotfiles/nvim/indent/python.vim ~/.vim/indent/python.vim
ln -sf ~/.dotfiles/nvim ~/.config/nvim
ln -sf ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/ssh_client_config ~/.ssh/config
ln -sf ~/.dotfiles/alacritty.yml ~/.config/alacritty/
ln -sf ~/.dotfiles/pylintrc ~/.pylintrc
ln -sf ~/.dotfiles/gitignore ~/.gitignore
ln -sf ~/.dotfiles/yamllint ~/.config/
ln -sf ~/.dotfiles/zshrc_mac ~/.zshrc
ln -sf ~/.dotfiles/mysql/cn.cnf ~/.cn.cnf
ln -sf ~/.dotfiles/ctags ~/.ctags
ln -sf ~/.dotfiles/kitty.conf ~/.config/kitty/kitty.conf

ln -sf ~/.dotfiles/dircolors ~/.dircolors

ln -sf ~/.dotfiles/bashrc ~/.bashrc
cp ~/.dotfiles/gitconfig_template ~/.gitconfig
ln -sf ~/.dotfiles/pdbrc.py ~/.pdbrc.py
ln -sf ~/.dotfiles/gdb/gdbinit ~/.gdbinit
ln -sf ~/.dotfiles/tmux/tmux_yank.sh ~/bin/yank
ln -sf ~/.dotfiles/gdb/nasm_compile.sh ~/bin/comp
ln -sf ~/.dotfiles/gdb/nasm_compile32.sh ~/bin/comp32
ln -sf ~/.dotfiles/gdb/nasm_compile_win32.sh ~/bin/compw
ln -sf ~/.dotfiles/vim/py_vim_filters/network.py ~/bin/network
ln -sf ~/.dotfiles/vim/py_vim_filters/bytearray.py ~/bin/bytearray
ln -sf ~/.dotfiles/vim/py_vim_filters/pc.py ~/bin/pc
ln -sf ~/.dotfiles/vim/py_vim_filters/po.py ~/bin/po
ln -sf ~/.dotfiles/vim/py_vim_filters/fromassembly.py ~/bin/fromassembly
ln -sf ~/.dotfiles/vim/py_vim_filters/fromopcodes.py ~/bin/fromopcodes
ln -sf ~/.dotfiles/setup/keys_macos_regkb.sh ~/bin/kint
ln -sf ~/.dotfiles/setup/keys_macos_extkb.sh ~/bin/kext
ln -sf ~/.dotfiles/setup/keys_default.sh ~/bin/kdef

cd ~
echo 'setting up terminfo (italics support!)'
# https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be

tic -xo $HOME/.terminfo ~/.dotfiles/xterm-256color-italic.terminfo
tic -xo $HOME/.terminfo ~/.dotfiles/tmux/tmux-256color.terminfo

echo 'setting up directories and symlinks..done!'

# setup omzsh

defaults -currentHost write -g AppleFontSmoothing -int 0
defaults write com.googlecode.iterm2 AppleFontSmoothing -integer 1

cd ~/.dotfiles/setup

. ./setup_omzsh.sh

# ~/.fzf/install
