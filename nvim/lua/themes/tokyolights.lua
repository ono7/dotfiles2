-- Colorscheme generated by https://github.com/arcticlimer/djanho
vim.cmd[[highlight clear]]

local highlight = function(group, bg, fg, attr)
    fg = fg and 'guifg=' .. fg or ''
    bg = bg and 'guibg=' .. bg or ''
    attr = attr and 'gui=' .. attr or ''

    vim.api.nvim_command('highlight ' .. group .. ' '.. fg .. ' ' .. bg .. ' '.. attr)
end

local link = function(target, group)
    vim.api.nvim_command('highlight! link ' .. target .. ' '.. group)
end

local Color0 = '#526270'
local Color5 = '#BB9AF7'
local Color15 = '#ffffff'
local Color3 = '#FF5370'
local Color12 = '#5c2a31'
local Color2 = '#9ECE6A'
local Color1 = '#FF9E64'
local Color11 = '#204729'
local Color13 = '#28323a'
local Color14 = '#41505e'
local Color7 = '#7AA2F7'
local Color6 = '#C0F0F5'
local Color4 = '#89DDFF'
local Color8 = '#b7c5d3'
local Color9 = '#1d252c'
local Color10 = '#d8e2ec'

highlight('Comment', nil, nil, 'italic')
highlight('Comment', nil, Color0, nil)
highlight('Number', nil, Color1, nil)
highlight('String', nil, Color2, nil)
highlight('Error', nil, Color3, nil)
highlight('Operator', nil, Color4, nil)
highlight('Keyword', nil, Color5, nil)
highlight('Conditional', nil, Color5, nil)
highlight('Repeat', nil, Color5, nil)
highlight('Identifier', nil, Color6, nil)
highlight('Function', nil, Color7, nil)
highlight('TSCharacter', nil, Color5, nil)
highlight('StatusLine', Color8, Color9, nil)
highlight('WildMenu', Color9, Color10, nil)
highlight('Pmenu', Color9, Color10, nil)
highlight('PmenuSel', Color10, Color9, nil)
highlight('PmenuThumb', Color9, Color10, nil)
highlight('DiffAdd', Color11, nil, nil)
highlight('DiffDelete', Color12, nil, nil)
highlight('Normal', Color9, Color10, nil)
highlight('Visual', Color13, nil, nil)
highlight('CursorLine', Color13, nil, nil)
highlight('ColorColumn', Color13, nil, nil)
highlight('SignColumn', Color9, nil, nil)
highlight('LineNr', nil, Color14, nil)
highlight('TabLine', Color9, Color8, nil)
highlight('TabLineSel', Color15, Color9, nil)
highlight('TabLineFill', Color9, Color8, nil)
highlight('TSPunctDelimiter', nil, Color10, nil)

link('TSFunction', 'Function')
link('TSPunctBracket', 'MyTag')
link('CursorLineNr', 'Identifier')
link('Folded', 'Comment')
link('NonText', 'Comment')
link('TSConditional', 'Conditional')
link('TSConstant', 'Constant')
link('TSNamespace', 'TSType')
link('TelescopeNormal', 'Normal')
link('TSParameterReference', 'TSParameter')
link('TSNumber', 'Number')
link('TSField', 'Constant')
link('TSComment', 'Comment')
link('TSLabel', 'Type')
link('TSTag', 'MyTag')
link('TSProperty', 'TSField')
link('TSString', 'String')
link('TSParameter', 'Constant')
link('TSKeyword', 'Keyword')
link('TSPunctSpecial', 'TSPunctDelimiter')
link('TSOperator', 'Operator')
link('TSConstBuiltin', 'TSVariableBuiltin')
link('Macro', 'Function')
link('TSType', 'Type')
link('Whitespace', 'Comment')
link('TSTagDelimiter', 'Type')
link('TSRepeat', 'Repeat')
link('Conditional', 'Operator')
link('TSFloat', 'Number')
link('TSFuncMacro', 'Macro')
link('Repeat', 'Conditional')
link('Operator', 'Keyword')
