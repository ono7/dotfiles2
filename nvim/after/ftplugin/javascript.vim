setlocal ai ts=2 sw=2 et fo-=r fo-=o

setlocal suffixesadd+=.js

" ES6 - defines what vim's include look up should parse
setlocal include=^\\s*[^\/]\\+\\(from\\\|require(['\"]\\)

" transforms what is found with vim's include lookup
setlocal includeexpr=substitute(v:fname,'\\.','/','g')
