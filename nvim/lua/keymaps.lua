-- nnoremap <silent><leader>t :silent !tmux send-keys -t 2 c-p Enter<cr>
-- " select visualy selected text for search
-- xnoremap <enter> y/\V<C-r>=escape(@",'/\')<CR><CR>

local map = vim.api.nvim_set_keymap

options = {noremap = true}
silent = {noremap = true, silent = true}

-- leader
map("n", "<Space>", "", {})
vim.g.mapleader = " " -- 'vim.g' sets global variables

-- pure sauce
map("i", "jk", "<esc><cmd>noh<cr><c-g>", silent)

-- disable c-z (bg)
map("n", "<c-z>", "<nop>", options)
map("c", "<c-z>", "<nop>", options)

map("n", "cp", "yap<S-}>p", options)

-- macros
map("n", "Q", "@q", options)

map("n", "<leader>ve", ":e $MYVIMRC<cr>", options)

map("n", "H", "^", options)
map("n", "L", "g_", options)
map("v", "H", "^", options)
map("v", "L", "g_", options)
map("n", "U", "<c-r>", options)
map("c", "%s", [[%s/\v]], options)
map("c", "%g", [[%g/\v]], options)
map("c", "%v", [[%v/\v]], options)

-- marks/jumps
map("n", "'", "`", options)
map("n", "/", [[ms/\v]], options)
map("x", "/", [[ms/\v]], options)
map("n", "?", [[ms?\v]], options)
map("x", "?", [[ms?\v]], options)
map("n", "gg", "msgg<c-g>", options)
map("n", "G", "msG<c-g>", options)
map("n", "gd", "msgd", options)
map("n", "*", "ms*", options)
map("n", "#", "ms#", options)
map("n", "V", "Vg_", {})

-- buffer ops
map("n", "<leader>w", ":write<cr>", options)
map("n", "<tab>", ":bnext<cr>", silent)
map("n", "<s-tab>", ":bprevious<cr>", silent)
map("n", "Y", "y$", options)
map("v", "y", "mxy`x", options)

-- terminal
map("t", "jk", [[<c-\><c-n>]], options)

-- ale
map("n", "[n", "<Plug>(ale_next_wrap)", {silent = true})
map("n", "]n", "<Plug>(ale_previous_wrap)", {silent = true})

-- coc
map("i", "<expr> <C-c>", "coc#refresh()", silent)

-- surround
vim.g.surround_no_mappings = 1
map("n", "S", "<Plug>YSurround", {})
map("n", "s", "<Plug>Ysurround", {})
map("n", "sw", "<Plug>YsurroundiW", {})
map("n", "ys", "<Plug>Yssurround", {})
map("n", "ds", "<Plug>Dsurround", {})
map("n", "cs", "<Plug>Csurround", {})
map("x", "s", "<Plug>Vsurround", {})

-- visual select search
map("x", "<enter>", [[y/\V<C-r>=escape(@",'/\')<CR><CR>]], silent)
