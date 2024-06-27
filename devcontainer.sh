#!/usr/bin/env bash

d=$(pwd)

cd

pwd

. ./setup/setup_dirs.sh

cd $d

# install Nix packages from config.nix
# nix-env -iA nixpkgs.myPackages
