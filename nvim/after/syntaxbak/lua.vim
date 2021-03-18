syn keyword luaKeywords end
syn keyword luaKeywords else
syn keyword luaKeywords elseif
syn keyword luaKeywords then
syn keyword luaKeywords do
syn keyword luaKeywords and
syn keyword luaKeywords or
syn keyword luaKeywords in
hi! def link luaKeywords RedItalic

syn keyword luaKeywords1 self
hi! def link luaKeywords1 Red

syn keyword luaKeywords2 local
hi! def link luaKeywords2 Aqua

hi! link luaCond RedItalic
hi! link luaFunction RedItalic
hi! link luaFunctionBlock AquaItalic
hi! link luaRepeat RedItalic
hi! link luaStatement RedItalic
hi! link luaNumber Yellow
hi! link luaFunc Yellow
hi! link luaTable Orange
hi! link luaConstant Yellow

syn match group6 /\v[\(\)]/
hi! link group6 Purple

syn match luaMathOp /\v[\/\%\^\&\$\\|\{\}]/
hi! link luaMathOp Orange

" syn match luaCompOp /\v[<>~]/
" hi! link luaCompOp NormalBold

syn match luaCompOp1 /\v[=~.+/%*#<>]/
hi! link luaCompOp1 Blue

syn match luaCompOp3 /\v[,]/
hi! link luaCompOp3 Normal

syn match luaCompOp4 /\v[!]/
hi! link luaCompOp4 RedBold
