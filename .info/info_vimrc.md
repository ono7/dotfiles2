# You can use built-in profiling support to detect slow issues with vim: after launching vim do

:profile start profile.log
:profile func *
:profile file *
" At this point do slow actions
" :profile pause
" :noautocmd qall!

# good vimrc file
https://github.com/r00k/dotfiles/blob/master/vimrc

# install command-t dependencies

sudo apt install ruby-dev rubygems gcc

cd ~/.vim/bundle/command-t

rake make


