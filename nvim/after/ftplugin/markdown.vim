setlocal number nowrap tw=79
setlocal ai ts=2 sw=2 et fo-=r fo-=o
" syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained conceal
" syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart concealends

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
