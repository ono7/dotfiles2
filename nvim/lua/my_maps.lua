-- my_maps

local m = vim.api.nvim_set_keymap

local options = {noremap = true}
local silent = {noremap = true, silent = true}
local ens = {expr = true, noremap = true, silent = true}
local en = {noremap = true, expr = true}

-- completion
function _G.check_back_space()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  return (col == 0 or vim.api.nvim_get_current_line():sub(col, col):match("%s")) and true
end

m("i", "<Tab>", [[pumvisible() ? '<c-n>' : v:lua.check_back_space() ? '<tab>' : coc#refresh() ]], ens)
m("i", "<S-Tab>", "pumvisible() ? '<C-p>' : '<S-Tab>'", en)

-- snippets
-- m("i", "<c-l>", [[<Plug>(coc-snippets-expand-jump)]], {}) -- expand
-- m("v", "<c-j>", [[<Plug>(coc-snippets-select)]], {}) -- visual select

-- resize window
m("n", "<M-j>", [[:resize -2<cr>]], silent)
m("n", "<M-k>", [[:resize +2<cr>]], silent)
m("n", "<M-h>", [[:vertical resize -2<cr>]], silent)
m("n", "<M-l>", [[:vertical resize +2<cr>]], silent)

-- tmux
m("n", "<leader>t", [[:silent !tmux send-keys -t 2 c-p Enter<cr>]], silent)

-- select visualy selected text for search
m("v", "<enter>", [[y/\V<C-r>=escape(@",'/\')<CR><CR>]], silent)

m("n", "<leader>ve", ":Files ~/.dotfiles/nvim/<cr>", options)

m("n", "H", "^", options)
m("n", "L", "g_", options)
m("v", "H", "^", options)
m("v", "L", "g_", options)
m("c", "%s", [[%s/\v]], options)
m("c", "%g", [[%g/\v]], options)
m("c", "%v", [[%v/\v]], options)

-- marks/jumps
m("n", "'", "`", options)
m("n", "/", [[ms/]], options)
m("x", "/", [[ms/]], options)
m("n", "?", [[ms?]], options)
m("x", "?", [[ms?]], options)
m("n", "gg", "msgg<c-g>", options)
m("n", "G", "msG<c-g>", options)
m("n", "gd", "msgd", options)
m("n", "*", "ms*", options)
m("n", "#", "ms#", options)
m("n", "V", "Vg_", {})

-- terminal
m("t", "jk", [[<c-\><c-n>]], options)

-- ale
m("n", "[n", "<Plug>(ale_next_wrap)", {silent = true})
m("n", "]n", "<Plug>(ale_previous_wrap)", {silent = true})

-- fzf
m("n", "<c-p>", ":GFiles<cr>", silent)
m("n", "<leader>f", ":Files<cr>", silent)
m("n", "<leader>b", ":Buffers<cr>", silent)

-- coc
m("i", "<c-j>", "", {}) -- nop
m("i", "<c-j>", [[coc#refresh()]], ens)
m("n", "gr", [[<Plug>(coc-references)]], {silent = true})
m("n", "<leader>g", [[<Plug>(coc-definition)]], {silent = true})

-- surround
vim.g.surround_no_mappings = 1
m("n", "S", "<Plug>YSurround", {})
m("n", "s", "<Plug>Ysurround", {})
m("n", "sw", "<Plug>YsurroundiW", {})
m("n", "ys", "<Plug>Yssurround", {})
m("n", "ds", "<Plug>Dsurround", {})
m("n", "cs", "<Plug>Csurround", {})
m("x", "S", "<Plug>VSurround", {})

-- miniyank
m("n", "p", [[<Plug>(miniyank-autoput)]], {})
m("n", "P", [[<Plug>(miniyank-autoPut)]], {})

-- nvimtree
m("n", "<c-e>", [[:NvimTreeToggle<cr>]], silent)

-- spell
m("n", "<leader>e", [[]s1z=]], silent)

-- shellcode
m(
  "x",
  "<space>h",
  [[:s/\v\s+//ge<cr><bar> :s/\v(..)/\\\x\1/ge<cr><bar> :s/\v.*/buffer \+\= b"&"/ge<cr>:noh<cr>]],
  silent
)

-- vimwiki throw away bindings
m("n", [[\xa]], [[<Plug>VimwikiIndex]], options)
m("n", [[\xb]], [[<Plug>VimwikiTabIndex]], options)
m("n", [[\xc]], [[<Plug>VimwikiUISelect]], options)
m("n", [[\xd]], [[<Plug>VimwikiDiaryIndex]], options)
m("n", [[\xe]], [[<Plug>VimwikiRenameFile]], options)
m("n", [[\xf]], [[<Plug>VimwikiDeleteFile]], options)
m("n", [[\xg]], [[<Plug>VimwikiGoto]], options)
m("n", [[\xh]], [[<Plug>Vimwiki2HTMLBrowse]], options)
m("n", [[\xi]], [[<Plug>Vimwiki2HTML]], options)
m("n", [[\xj]], [[<Plug>VimwikiMakeTomorrowDiaryNote]], options)
m("n", [[\xk]], [[<Plug>VimwikiMakeYesterdayDiaryNote]], options)
m("n", [[\xl]], [[<Plug>VimwikiTabMakeDiaryNote]], options)
m("n", [[\xm]], [[<Plug>VimwikiMakeDiaryNote]], options)
m("n", [[\xn]], [[<Plug>VimwikiDiaryGenerateLinks]], options)

-- " remove any spaces and un-hexify (visual select)
-- xnoremap <silent>\h :s/\v\s+//ge<cr><bar> :s/\v\\x//ge<cr> :noh<cr>

-- " remove any spaces/shellcode
-- xnoremap <silent><leader>s ^ :s/\v\s+//ge<cr><bar> :noh<cr>
