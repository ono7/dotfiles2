-- todo: reload init.lua??
-- nnoremap <silent><leader>t :silent !tmux send-keys -t 2 c-p Enter<cr>
local map = vim.api.nvim_set_keymap

options = { noremap = true }

-- leader
map('n', '<Space>', '', {})
vim.g.mapleader = ' '  -- 'vim.g' sets global variables

-- pure sauce
map('i', 'jk', '<esc><cmd>noh<cr><c-g>', options)

-- disable c-z (bg)
map('n', '<c-z>', '<nop>', options)
map('c', '<c-z>', '<nop>', options)

map('n', 'cp', 'yap<S-}>p', options)

-- macros
map('n', 'Q', '@q', options)

map('n', '<leader>ve', ':e $MYVIMRC<cr>', options)


map('n', 'H', '^', options)
map('n', 'L', 'g_', options)
map('v', 'H', '^', options)
map('v', 'L', 'g_', options)
map('n', 'U', '<c-r>', options)
map('c', '%s', [[%s/\v]], options)
map('c', '%g', [[%g/\v]], options)
map('c', '%v', [[%v/\v]], options)

-- marks/jumps
map('n', '\'', '`', options)
map('n', '/', [[ms/\v]], options)
map('x', '/', [[ms/\v]], options)
map('n', '?', [[ms?\v]], options)
map('x', '?', [[ms?\v]], options)
map('n', 'gg', 'msgg<c-g>', options)
map('n', 'G', 'msG<c-g>', options)
map('n', 'gd', 'msgd', options)
map('n', '*', 'ms*', options)
map('n', '#', 'ms#', options)
map('n', 'V', 'Vg_', {})

