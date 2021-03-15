
" function parentheses
syn match group6 /\v[\(\)]/
hi! link group6 Purple

" function parentheses
syn match group6 /\v[\{\}]/
hi! link group6 Purple

syn match tfMathOp /\v[\+\-\*\/\%\^\&\$\\|\{\}=]/
hi! link tfMathOp Orange

syn match tfCompOp /\v[=!<>~+-]/
hi! link tfCompOp Normal

hi! link terraRepeat RedItalic
hi! link terraConditional RedItalic

hi! link terraType YellowItalic
hi! link terraBlockType RedItalic

hi! link terraBraces Purple

hi! link terraValueDec Yellow

syn keyword tfKeyWords for
syn keyword tfKeyWords while
syn keyword tfKeyWords provisioner
syn keyword tfKeyWords provider
hi! def link tfKeyWords RedItalic
