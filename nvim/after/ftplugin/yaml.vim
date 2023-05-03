setlocal number ai ts=2 sts=2 sw=2 et fo-=c fo-=r fo-=o
setlocal makeprg=yamllint\ --f\ parsable\ %
setlocal errorformat=%f:%l:\ %m

setlocal suffixesadd+=.yml
setlocal suffixesadd+=.yaml

