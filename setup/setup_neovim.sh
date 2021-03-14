#/bin/bash

echo "$0"

cd ~

echo 'setting up neovim gem..'
if [ $(which gem) ]; then
  `which gem` install --user-install neovim
else
  echo "$0"
  echo 'no gem executable found..'
fi

# setup dirs/symlinks if they do not exists
# crude way of testing... but.. whatever

echo 'setting up neovim dirs, if not present...'
if [ ! -d ~/.config/nvim ]; then
  echo 'critical directories not founds..setting up..'
  . ./setup_dirs.sh
fi

if [ ! -d ~/.virtualenvs/prod3/bin ]; then
  echo 'no virtualenv detected... installing..'
  . ./setup_virtualenv.sh
fi

# needed to share rign for miniyank vim plugin/unnamedplus v-block paste issues
touch ~/.tmp/miniyank-shared-ring

echo 'setting up neovim plugins...'
# setup vim plugins
if [ $(which nvim) ]; then
  nvim_cmd=`which nvim`
  # setup vim pluging manager
  # if [ ! -f ~/.config/nvim/autoload/plug.vim ]; then
  echo 'setting up neovim plugin manager...'
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  #   if [ $? -ne 0 ]; then
  #     echo "$0"
  #     echo 'problem setting up neovim plugin manager... check internet connection'
  #     exit 1
  #   fi
  # fi
  $nvim_cmd +PlugUpdate +qall
  $nvim_cmd +PlugInstall +qall
  $nvim_cmd +PlugUpgrade +qall
  $nvim_cmd +UpdateRemotePlugins +qall
  $nvim_cmd +CocInstall coc-python +qall
  $nvim_cmd +CocInstall coc-javascript +qall
  $nvim_cmd +CocInstall coc-json +qall
else
  echo "$0"
  echo 'no neovim instance found...running vanilla vim?'
  exit 0
fi

echo 'vim/neovim setup done..'
