

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
# if [ $(which nvim) ]; then
#   $nvim_cmd +PaqInstall +qall
#   $nvim_cmd +UpdateRemotePlugins +qall
#   $nvim_cmd +TSInstall all +qall
#   $nvim_cmd +LspInstall python +qall
#   $nvim_cmd +LspInstall json +qall
#   $nvim_cmd +LspInstall typescript +qall
#   $nvim_cmd +LspInstall yaml +qall
#   $nvim_cmd +LspInstall vim +qall
# else
#   echo "$0"
#   echo 'no neovim instance found...running vanilla vim?'
#   exit 0
# fi

echo 'vim/neovim setup done.., dont for get to :LspInstall language servers!'


