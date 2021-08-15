local m = vim.api.nvim_set_keymap
local opt = {noremap = true}
local silent = {noremap = true, silent = true}

--- resize window ---
m("n", "<M-j>", [[:resize -2<cr>]], silent)
m("n", "<M-k>", [[:resize +2<cr>]], silent)
m("n", "<M-h>", [[:vertical resize -2<cr>]], silent)
m("n", "<M-l>", [[:vertical resize +2<cr>]], silent)

--- send to tmux ---
m("n", "<leader>t", [[:silent !tmux send-keys -t 2 c-p Enter<cr>]], silent)

--- visual selection search ---
m("v", "<enter>", [[y/\V<C-r>=escape(@",'/\')<CR><CR>]], silent)

m("n", "<leader>ve", ":Files ~/.dotfiles/<cr>", opt)
m("n", "<leader>vr", ":source ~/.dotfiles/nvim/ini.lua<cr>", opt)

--- marks/jumps ---
m("n", "'", "`", opt)
m("n", "ma", "mA", opt)
m("n", "ss", "mS", opt)
m("n", "mb", "mB", opt)
m("n", "mc", "mC", opt)
m("n", "mm", "mM", opt)
m("n", "ms", "mS", opt)
m("n", "'a", "`A", opt)
m("n", "'b", "`B", opt)
m("n", "'c", "`C", opt)
m("n", "'m", "`M", opt)
m("n", "'s", "`S", opt)

m("n", "gg", "gg1<c-g>", opt)
m("n", "G", "G1<c-g>", opt)
m("n", "V", "Vg_", {})

--- terminal ---
m("t", "<c-[>", [[<c-\><c-n>]], silent)

--- ale ---
m("n", "<c-n>", "<Plug>(ale_next_wrap)", {silent = true})
m("n", "<c-p>", "<Plug>(ale_previous_wrap)", {silent = true})

--- fzf ---
m("n", "<c-f>", ":Files<cr>", silent)
m("n", "<leader>f", ":GFiles<cr>", silent)
m("n", "<leader>b", ":Buffers<cr>", silent)
m("n", "<leader>s", ":Rg<cr>", silent)

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
m("n", "<M-t>", [[:NvimTreeToggle<cr>]], silent)

--- spell ---
m("n", "<leader>e", [[]s1z=]], silent)

--- shellcode ---
m(
  "x",
  "<space>h",
  [[:s/\v\s+//ge<cr><bar> :s/\v(..)/\\\x\1/ge<cr><bar> :s/\v.*/buffer \+\= b"&"/ge<cr>:noh<cr>]],
  silent
)

--[[

  " remove any spaces and un-hexify (visual select)
  xnoremap <silent>\h :s/\v\s+//ge<cr><bar> :s/\v\\x//ge<cr> :noh<cr>

  " remove any spaces/shellcode
  xnoremap <silent><leader>s ^ :s/\v\s+//ge<cr><bar> :noh<cr>

--]]
