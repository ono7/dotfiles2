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
mkdir -p ~/.tmux/plugins
mkdir -p ~/.ssh
mkdir -p ~/bin
mkdir -p ~/.npm-packages
mkdir -p ~/local

echo ################################################################################
echo #                              creating symlinks                               #
echo ################################################################################

rm -rf ~/.vim
rm -rf ~/.config/nvim
ln -sf ~/.dotfiles/vim ~/.vim
ln -sf ~/.dotfiles/vim ~/.config/nvim
ln -sf ~/.dotfiles/vim/init.vim ~/.vimrc
ln -sf ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/ssh_client_config ~/.ssh/config
ln -sf ~/.dotfiles/alacritty.yml ~/.config/alacritty/
ln -sf ~/.dotfiles/pylintrc ~/.pylintrc
ln -sf ~/.dotfiles/gitignore ~/.gitignore
ln -sf ~/.dotfiles/yamllint ~/.config/
ln -sf ~/.dotfiles/zshrc_mac ~/.zshrc
ln -sf ~/.dotfiles/mysql/cn.cnf ~/.cn.cnf
ln -sf ~/.dotfiles/pdbrc ~/.pdbrc
ln -sf ~/.dotfiles/ctags ~/.ctags



ln -sf ~/.dotfiles/dircolors ~/.dircolors

ln -sf ~/.dotfiles/bashrc ~/.bashrc
ln -sf ~/.dotfiles/gitconfig ~/.gitconfig
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

ln -sfn ~/.dotfiles/fish ~/.config/

# on home macbook only
# curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
# fisher add rafaelrinaldi/pure

# ln -sf ~/.dotfiles/vim/py_vim_filters/network.py ~/bin/network
# ln -sf ~/.dotfiles/vim/py_vim_filters/pattern.py ~/bin/pattern

cd ~
echo 'setting up terminfo (italics support!)'
# https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be

tic -xo $HOME/.terminfo ~/.dotfiles/xterm-256color-italic.terminfo
tic -xo $HOME/.terminfo ~/.dotfiles/tmux/tmux-256color.terminfo

echo 'setting up directories and symlinks..done!'

# setup omzsh

cd ~/.dotfiles/setup

. ./setup_omzsh.sh

~/.fzf/install
