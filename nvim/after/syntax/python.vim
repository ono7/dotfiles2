""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 definitions                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" http://vimregex.com

" https://vi.stackexchange.com/questions/13603/regex-to-match-any-character-including-newline?rq=1
"
" clear some performance issues
silent! syn clear pythonFunction
silent! syn clear pythonMatrixMultiply
silent! syn clear pythonString
silent! syn clear pythonRawString

" redefine how class is handled so that we get a different color, class name..
syn keyword myClass class
hi! def link myClass RedItalic
" syn keyword myClass class nextgroup=myClassName skipwhite

" syn match myClassName "\v<[A-Z]+[a-z]\w+"
syn match myClassName "\v<[A-Z]+\w+"
hi! link myClassName Orange

" redefine other keyboards
syn keyword myKeyWords break
syn keyword myKeyWords def
syn keyword myKeyWords as
syn keyword myKeyWords with
syn keyword myKeyWords return
syn keyword myKeyWords try
syn keyword myKeyWords execpt
hi! def link myKeyWords RedItalic

" easy way to highlight, just create keyword groups and link to colors..
syn keyword group1 and
syn keyword group1 or
hi! def link group1 Orange

syn keyword group2 False
syn keyword group2 True
syn keyword group2 None
hi! link group2 Normal

syn keyword group3 self
hi! def link group3 CommentItalic

syn keyword group4 Exception
hi! def link group4 Fg

syn keyword group5 yield
syn keyword group5 continue
syn keyword group5 pass
syn keyword group5 assert
hi! def link group5 BlueItalic

" function parentheses
syn match group6 /\v[\(\)]/
hi! link group6 Purple

" function
syn match pyFunc /\v<[a-z_]\w+\ze\([^)]+\)\:/
hi! link pyFunc Normal

" syn match pyDot /\v[,;]/
" hi! link pyDot yellow_1

" syn match group7 /\v[\[\]]/
" hi! link group7 Purple

syn region pythonString start=/[uU]\=\z(['"]\)/ skip=/\\\\\|\\\z1/ end=/\z1/

" matches all docstrings
" syn region pyDocstr start=/[uU]\=\z('''\|"""\)/ skip=/\\["']/ end=/\z1/
" syn region pyDocstr start=/\(^\|^\s\+\)\z('''\|"""\)/ skip=/\\["']/ end=/\z1/

" match only doc strings that start with spaces
syn region pyDocstr start=/\(^\s\+\)\z('''\|"""\)/ skip=/\\["']/ end=/\z1/
hi! link pyDocstr Comment

" match docstrings only at the start of the line e.g. header
syn region pyDocstr2 start=/\(^\)\z('''\|"""\)/ skip=/\\["']/ end=/\z1/
hi! link pyDocstr2 Comment

" syn match pyMathOp /\v[\+\-\*\/\%\^\&\$\\|\{\}=]/
syn match pyMathOp /\v[\*\/\%\^\&\$\\|\{\}]/
hi! link pyMathOp Orange

syn match pyCompOp /\v[.,<>~;]/
hi! link pyCompOp Normal

syn match pyCompOp1 /\v[=:?]/
hi! link pyCompOp1 Blue

syn match pyCompOp4 /\v[!]/
hi! link pyCompOp4 Red

" syn match pySpecialComment "\v\##.*\ze:"
" hi! def link pySpecialComment Purple

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     special links for local definitions                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" try, execpt
hi! link pythonException RedItalic
hi! link pythonDecorator Purple
hi! link pythonDecoratorName Normal

" normalize from import.module
hi! def link pyImportDot Normal

" ops [+-/*!= <= >= == !]
hi! link pythonTodo PurpleItalic

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         original python.vim override                         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" default links are defined in:
"    /usr/local/Cellar/neovim/0.3.5/share/nvim/runtime/syntax

" python operator, for i in
hi! link pythonOperator RedItalic

" numbers
hi! link pythonNumber Yellow

" python built in sum, print, int, raw_input
hi! link pythonBuiltin Yellow

" from, import
hi! link pythonInclude BlueItalic
