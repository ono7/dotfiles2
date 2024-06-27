#!/usr/bin/env bash
# this is used by devcontainers to execute and install nix packages
# devup . --provider docker --dotfiles https://github.com/ono7/dotfiles2.git

# export XDG_CONFIG_HOME="$HOME"/.config
# mkdir -p "$XDG_CONFIG_HOME"
# mkdir -p "$XDG_CONFIG_HOME"/nixpkgs
#
# ln -sf "$PWD/nvim" "$XDG_CONFIG_HOME"/nvim

# TODO(jlima): add other dependencies here

# ln -sf "$PWD/bashrc" "$HOME"/.bashrc
# ln -sf "$PWD/zshrc_mac" "$HOME"/.zshrc
# ln -sf "$PWD/zshenv" "$HOME"/.zshenv
# ln -sf "$PWD/inputrc" "$HOME"/.inputrc
# ln -sf "$PWD/tmux/tmux.conf" "$HOME"/.tmux.conf
# ln -sf "$PWD/config.nix" "$XDG_CONFIG_HOME"/nixpkgs/config.nix

# install Nix packages from config.nix
# nix-env -iA nixpkgs.myPackages

git clone https://github/ono7/dotfiles2.git ~/.dotfiles

cd ~/.dotfiles/setup_shell_scripts

echo "$0"

echo ################################################################################
echo #                            setting up directories                            #
echo ################################################################################

cd ~
mkdir -p ~/.tmp
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/kitty
mkdir -p ~/.config/nixpkgs
mkdir -p ~/.tmux/plugins
mkdir -p ~/.ssh
mkdir -p ~/bin
mkdir -p ~/go
mkdir -p ~/.npm-packages
mkdir -p ~/local/bin

rm -rf ~/.vim
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim

echo ################################################################################
echo #                              creating symlinks                               #
echo ################################################################################

# make aliases and vars available in neovim

# this is for dev containers and wsl possibly
ln -sf ~/.dotfiles/config.nix ~/.config/nixpkgs/config.nix

ln -sf ~/.dotfiles/inputrc ~/.inputrc
ln -sf ~/.dotfiles/zshenv ~/.zshenv
ln -sf ~/.dotfiles/ctags.d ~/.ctags.d
ln -sf ~/.dotfiles/shortpath ~/local/bin/shortpath
ln -sf ~/.dotfiles/starship.toml ~/.config/
ln -sf ~/.dotfiles/ipython ~/.ipython
ln -sf ~/.dotfiles/mongorc.js ~/.mongorc.js
ln -sf ~/.dotfiles/mongorc.js ~/.mongoshrc.js
ln -sf ~/.dotfiles/nvim/indent/python.vim ~/.vim/indent/python.vim
ln -sf ~/.dotfiles/nvim ~/.config/nvim
ln -sf ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/ssh_client_config ~/.ssh/config
ln -sf ~/.dotfiles/alacritty.toml ~/.config/alacritty/
ln -sf ~/.dotfiles/pylintrc ~/.pylintrc
ln -sf ~/.dotfiles/gitignore ~/.gitignore
ln -sf ~/.dotfiles/yamllint ~/.config/
ln -sf ~/.dotfiles/zshrc_mac ~/.zshrc
ln -sf ~/.dotfiles/mysql/cn.cnf ~/.cn.cnf
ln -sf ~/.dotfiles/sqliterc ~/.sqliterc
ln -sf ~/.dotfiles/ctags ~/.ctags
ln -sf ~/.dotfiles/kitty.conf ~/.config/kitty/kitty.conf
ln -sf ~/.dotfiles/dircolors ~/.dircolors
ln -sf ~/.dotfiles/bashrc ~/.bashrc
ln -sf ~/nvim/bin/nvim ~/bin/vim
ln -sf ~/.dotfiles/pdbrc ~/.pdbrc
ln -sf ~/.dotfiles/ipdb ~/.ipdb
ln -sf ~/.dotfiles/gdb/gdbinit ~/.gdbinit
ln -sf ~/.dotfiles/setup/keys_macos_hhbk.sh ~/bin/kh
ln -sf ~/.dotfiles/gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/git_templates ~/.git_templates


cd ~

echo 'setting up directories and symlinks..done!'


# Skip the not really helping Ubuntu global compinit
if [[ $OSTYPE == "linux"* ]];  then
  echo '# compinit is done twice in ubuntu, skipping' > ~/.zshenv
  echo 'skip_global_compinit=1' >> ~/.zshenv
  echo "UPDATED COMPINIT SKIP SETTINGS FOR UBUNTU!!!"
fi

sudo apt update && sudo apt install -y neovim curl
sudo locale-gen en_US.UTF-8
sudo update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
