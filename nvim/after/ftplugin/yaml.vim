setlocal ai ts=2 sts=2 sw=2 et number
" setlocal fo-=c fo-=r fo-=o

setlocal suffixesadd+=.yml
setlocal suffixesadd+=.yaml

" Linting YAML

setlocal makeprg=yamllint\ --f\ parsable\ %
setlocal errorformat=%f:%l:%c:\ %m

" for reference only to use with vanilla vim
" augroup _QuickFixOpen
" 	autocmd!
" 	" auto open quickfix when executing make!
"   autocmd QuickFixCmdPost [^l]* cwindow
"   autocmd QuickFixCmdPost    l* lwindow
" augroup END
