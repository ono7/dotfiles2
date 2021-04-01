-- my_maps

local m = vim.api.nvim_set_keymap

-- local function b(...)
--   vim.api.nvim_buf_set_keymap(bufnr, ...)
-- end

local opt = {noremap = true}
local silent = {noremap = true, silent = true}
local ens = {expr = true, noremap = true, silent = true}

-- tab completion

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.smart_tab()
  return vim.fn.pumvisible() == 1 and t "<C-n>" or t "<Tab>"
end

m("i", "<Tab>", "v:lua.smart_tab()", ens)
m("i", "<S-Tab>", [[pumvisible() ? "<C-p>" : "<c-h>"]], ens)
-- m("i", "<c-j>", "", {}) -- nop
-- m("i", "<c-j>", [[<Plug>(completion_trigger)]], {})

-- resize window

m("n", "<M-j>", [[:resize -2<cr>]], silent)
m("n", "<M-k>", [[:resize +2<cr>]], silent)
m("n", "<M-h>", [[:vertical resize -2<cr>]], silent)
m("n", "<M-l>", [[:vertical resize +2<cr>]], silent)

-- tmux

m("n", "<leader>t", [[:silent !tmux send-keys -t 2 c-p Enter<cr>]], silent)

-- select visualy selected text for search

m("v", "<enter>", [[y/\V<C-r>=escape(@",'/\')<CR><CR>]], silent)

m("n", "<leader>ve", ":Files ~/.dotfiles/nvim/<cr>", opt)

m("n", "H", "^", opt)
m("n", "L", "g_", opt)
m("v", "H", "^", opt)
m("v", "L", "g_", opt)
m("c", "%s", [[%s/\v]], opt)
m("c", "%g", [[%g/\v]], opt)
m("c", "%v", [[%v/\v]], opt)

-- marks/jumps

m("n", "'", "`", opt)
m("n", "/", [[ms/]], opt)
m("x", "/", [[ms/]], opt)
m("n", "?", [[ms?]], opt)
m("x", "?", [[ms?]], opt)
m("n", "gg", "msgg<c-g>", opt)
m("n", "G", "msG<c-g>", opt)
m("n", "gd", "msgd", opt)
m("n", "*", "ms*", opt)
m("n", "#", "ms#", opt)
m("n", "V", "Vg_", {})

-- terminal

m("t", "jk", [[<c-\><c-n>]], opt)

-- ale

m("n", "<c-n>", "<Plug>(ale_next_wrap)", {silent = true})
m("n", "<c-p>", "<Plug>(ale_previous_wrap)", {silent = true})

-- quickfix overlaps with ale :(
-- m("n", "<c-n>", [[:cnext<cr>]], silent)
-- m("n", "<c-p>", [[:cprevious<cr>]], silent)

-- fzf

m("n", "<leader>t", ":GFiles<cr>", silent)
m("n", "<leader>f", ":Files<cr>", silent)
m("n", "<leader>b", ":Buffers<cr>", silent)

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

m("n", [[\xa]], [[<Plug>VimwikiIndex]], opt)
m("n", [[\xb]], [[<Plug>VimwikiTabIndex]], opt)
m("n", [[\xc]], [[<Plug>VimwikiUISelect]], opt)
m("n", [[\xd]], [[<Plug>VimwikiDiaryIndex]], opt)
m("n", [[\xe]], [[<Plug>VimwikiRenameFile]], opt)
m("n", [[\xf]], [[<Plug>VimwikiDeleteFile]], opt)
m("n", [[\xg]], [[<Plug>VimwikiGoto]], opt)
m("n", [[\xh]], [[<Plug>Vimwiki2HTMLBrowse]], opt)
m("n", [[\xi]], [[<Plug>Vimwiki2HTML]], opt)
m("n", [[\xj]], [[<Plug>VimwikiMakeTomorrowDiaryNote]], opt)
m("n", [[\xk]], [[<Plug>VimwikiMakeYesterdayDiaryNote]], opt)
m("n", [[\xl]], [[<Plug>VimwikiTabMakeDiaryNote]], opt)
m("n", [[\xm]], [[<Plug>VimwikiMakeDiaryNote]], opt)
m("n", [[\xn]], [[<Plug>VimwikiDiaryGenerateLinks]], opt)

-- " remove any spaces and un-hexify (visual select)
-- xnoremap <silent>\h :s/\v\s+//ge<cr><bar> :s/\v\\x//ge<cr> :noh<cr>

-- " remove any spaces/shellcode
-- xnoremap <silent><leader>s ^ :s/\v\s+//ge<cr><bar> :noh<cr>
