silent! syn clear yamlSingleEscape
silent! syn clear yamlFlowString
silent! syn clear yamlPlainScalar

syn match Group1 /\v[']/
syn match Group1 /\v["]/
hi! link Group1 Green

hi! link yamlFlowIndicator Purple

hi! link yamlNodeTag Red

syn match yamlCompOp /\v[.,<>~]/
hi! link yamlCompOp Normal

syn match yamlCompOp1 /\v[=:?]/
hi! link yamlCompOp1 Blue

syn match yamlCompOp3 /\v[;]/
hi! link yamlCompOp3 Normal

syn match yamlCompOp4 /\v[!]/
hi! link yamlCompOp4 Red
