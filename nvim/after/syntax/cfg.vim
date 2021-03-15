syn match CfgSection /\v^\[.*\]$/
" syn match CfgRange /\v(\w+)@<=\[.*\](\w+)@=/
syn match CfgRange /\v(\S+)@<=\[\w+\:\w+]/

hi link CfgSection green_1_bold
hi link CfgRange red_1
