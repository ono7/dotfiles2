setlocal nowrap
setlocal ai ts=2 sw=2 et fo-=r fo-=o fo-=c

setlocal nofoldenable
setlocal suffixesadd+=.md

" Linting YAML
setlocal makeprg=yamllint\ --f\ parsable\ %
setlocal errorformat=%f:%l:\ %m

augroup YAMLquickfix
    autocmd!
    " auto open quickfix when executing make!
    autocmd FileType yaml autocmd QuickFixCmdPost [^l]* cwindow
    autocmd FileType yaml autocmd QuickFixCmdPost    l* lwindow
augroup END
