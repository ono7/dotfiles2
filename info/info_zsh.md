# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install powerline theme
# run cd oh-my-zsh-powerline-theme && ./install_in_omz.sh
git clone https://github.com/jeremyFreeAgent/oh-my-zsh-powerline-theme.git


# profile slow issues

brew install moreutils
call zsh -xv 2>&1 | ts -i "%.s" > zsh_startup.log
sort by time sort --field-separator=' ' -r -k1 zsh_startup.log> sorted.log
and see what loaded too slow. For me, it was a ruby plugin which needs a 3 second to loads
