--- locals ---
local m = vim.api.nvim_set_keymap
local opt = {noremap = true}
local silent = {noremap = true, silent = true}
local ens = {expr = true, noremap = true, silent = true}

--- tab completion ---
-- function _G.check_back_space()
--   local col = vim.api.nvim_win_get_cursor(0)[2]
--   return (col == 0 or vim.api.nvim_get_current_line():sub(col, col):match("%s")) and true
-- end

-- m("i", "<tab>", [[pumvisible() ? "<C-n>" : v:lua.check_back_space() ? "<tab>" : "<c-n>"]], ens)
-- m("i", "<S-Tab>", [[pumvisible() ? "<C-p>" : "<c-h>"]], ens)

--- resize window ---
m("n", "<M-k>", [[:resize -2<cr>]], silent)
m("n", "<M-j>", [[:resize +2<cr>]], silent)
m("n", "<M-h>", [[:vertical resize -2<cr>]], silent)
m("n", "<M-l>", [[:vertical resize +2<cr>]], silent)

--- send to tmux ---
m("n", "<leader>t", [[:silent !tmux send-keys -t 2 c-p Enter<cr>]], silent)

--- select visualy selected text for search ---
m("v", "<enter>", [[y/\V<C-r>=escape(@",'/\')<CR><CR>]], silent)

m("n", "<leader>ve", ":Files ~/.dotfiles/<cr>", opt)

-- in favor of faster window navigation, these are now disabled.. ---
m("n", "<c-a>", "^", opt)
m("n", "<c-e>", "g_", opt)
m("v", "<c-a>", "^", opt)
m("v", "<c-e>", "g_", opt)

-- m("c", "%s", [[%s/\v]], opt)
-- m("c", "%g", [[%g/\v]], opt)
-- m("c", "%v", [[%v/\v]], opt)

--- marks/jumps ---
m("n", "'", "`", opt)
m("n", "ma", "mA", opt)
m("n", "mb", "mB", opt)
m("n", "mc", "mC", opt)
m("n", "mm", "mM", opt)
m("n", "ms", "mS", opt)
m("n", "'a", "'A", opt)
m("n", "'b", "'B", opt)
m("n", "'c", "'C", opt)
m("n", "'m", "'M", opt)
m("n", "'s", "'S", opt)

m("n", "gg", "gg1<c-g>", opt)
m("n", "G", "G1<c-g>", opt)
m("n", "V", "Vg_", {})

--- terminal ---
-- m("n", "<c-t>", [[:split | resize 10 | term<cr>]], silent)
m("t", "<c-[>", [[<c-\><c-n>]], silent)

--- ale ---
m("n", "<c-n>", "<Plug>(ale_next_wrap)", {silent = true})
m("n", "<c-p>", "<Plug>(ale_previous_wrap)", {silent = true})

--- quickfix overlaps with ale :( ---
-- m("n", "<c-n>", [[:cnext<cr>]], silent)
-- m("n", "<c-p>", [[:cprevious<cr>]], silent)

--- fzf ---
m("n", "<leader>f", ":Files<cr>", silent)
m("n", "<leader>b", ":Buffers<cr>", silent)
m("n", "<leader>s", ":Rg<cr>", silent)
-- m("n", "<leader>c", ":Commits<cr>", silent) -- requires fugitive

vim.g.surround_no_mappings = 1
m("n", "S", "<Plug>YSurround", {})
m("n", "s", "<Plug>Ysurround", {})
m("n", "sw", "<Plug>Ysurroundiw", {})
m("n", "sW", "<Plug>YsurroundiW", {})
m("n", "ys", "<Plug>Yssurround", {})
m("n", "ds", "<Plug>Dsurround", {})
m("n", "cs", "<Plug>Csurround", {})
m("x", "S", "<Plug>VSurround", {})

--- miniyank ---
m("n", "p", [[<Plug>(miniyank-autoput)]], {})
m("n", "P", [[<Plug>(miniyank-autoPut)]], {})

--- nvimtree ---
m("n", "<c-t>", [[:NvimTreeToggle<cr>]], silent)

--- spell ---
m("n", "<leader>e", [[]s1z=]], silent)

--- shellcode ---
m(
  "x",
  "<space>h",
  [[:s/\v\s+//ge<cr><bar> :s/\v(..)/\\\x\1/ge<cr><bar> :s/\v.*/buffer \+\= b"&"/ge<cr>:noh<cr>]],
  silent
)

--- vimwiki throw away bindings ---
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

--[[

  " remove any spaces and un-hexify (visual select)
  xnoremap <silent>\h :s/\v\s+//ge<cr><bar> :s/\v\\x//ge<cr> :noh<cr>

  " remove any spaces/shellcode
  xnoremap <silent><leader>s ^ :s/\v\s+//ge<cr><bar> :noh<cr>

--]]
