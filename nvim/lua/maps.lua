local map = vim.api.nvim_set_keymap

options = {noremap = true}
silent = {noremap = true, silent = true}

-- tmux
map("n", "<leader>t", [[:silent !tmux send-keys -t 2 c-p Enter<cr>]], silent)

-- select visualy selected text for search
map("x", "<ender>", [[y/\V<C-r>=escape(@",'/\')<CR><CR>]], silent)

map("n", "<leader>ve", ":Files ~/.dotfiles/nvim/<cr>", options)

map("n", "H", "^", options)
map("n", "L", "g_", options)
map("v", "H", "^", options)
map("v", "L", "g_", options)
map("n", "U", "<c-r>", options)
map("c", "%s", [[%s/\v]], options)
map("c", "%g", [[%g/\v]], options)
map("c", "%v", [[%v/\v]], options)

-- indent and retain visual selection
map("v", ">", [[>gv]], options)
map("v", "<", [[<gv]], options)

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

-- terminal
map("t", "jk", [[<c-\><c-n>]], options)

-- ale
map("n", "[n", "<Plug>(ale_next_wrap)", {silent = true})
map("n", "]n", "<Plug>(ale_previous_wrap)", {silent = true})

-- fzf
map("n", "<c-p>", ":GFiles<cr>", silent)
map("n", "<leader>f", ":Files<cr>", silent)
map("n", "<leader>b", ":Buffers<cr>", silent)

-- coc
map("i", "<expr> <C-c>", "coc#refresh()", silent)
map("n", "gr", [[<Plug>(coc-references)]], {silent = true})
map("n", "<leader>g", [[<Plug>(coc-definition)]], {silent = true})

-- surround
vim.g.surround_no_mappings = 1
map("n", "S", "<Plug>YSurround", {})
map("n", "s", "<Plug>Ysurround", {})
map("n", "sw", "<Plug>YsurroundiW", {})
map("n", "ys", "<Plug>Yssurround", {})
map("n", "ds", "<Plug>Dsurround", {})
map("n", "cs", "<Plug>Csurround", {})
map("x", "s", "<Plug>Vsurround", {})

-- miniyank
map("n", "p", [[<Plug>(miniyank-autoput)]], {})
map("n", "P", [[<Plug>(miniyank-autoPut)]], {})

-- nvimtree
map("n", "<c-e>", [[:NvimTreeToggle<cr>]], silent)
