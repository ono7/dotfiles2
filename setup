#!/usr/bin/env bash
# this is used by devcontainers to execute and install nix packages
# devup . --provider docker --dotfiles https://github.com/ono7/dotfiles2.git

export XDG_CONFIG_HOME="$HOME"/.config
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_CONFIG_HOME"/nixpkgs

ln -sf "$PWD/nvim" "$XDG_CONFIG_HOME"/nvim

ln -sf "$PWD/.bash_profile" "$HOME"/.bash_profile
ln -sf "$PWD/.bashrc" "$HOME"/.bashrc
ln -sf "$PWD/.inputrc" "$HOME"/.inputrc
ln -sf "$PWD/.tmux.conf" "$HOME"/.tmux.conf
ln -sf "$PWD/config.nix" "$XDG_CONFIG_HOME"/nixpkgs/config.nix

# install Nix packages from config.nix
nix-env -iA nixpkgs.myPackages
