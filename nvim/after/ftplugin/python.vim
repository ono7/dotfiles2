" indent file is in ~/.dotfiles/nvim/indent/python.vim
setlocal expandtab nolisp autoindent number
setlocal indentkeys=!^F,o,O,<:>,0),0],0},=elif,=except

setlocal makeprg=pylint\ -sn\ -f\ text\ %

setlocal suffixesadd+=.py
