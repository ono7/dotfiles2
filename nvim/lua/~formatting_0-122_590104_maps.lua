local m = vim.api.nvim_set_keymap

options = {noremap = true}
silent = {noremap = true, silent = true}

-- tmux
m("n", "<leader>t", [[:silent !tmux send-keys -t 2 c-p Enter<cr>]], silent)

-- select visualy selected text for search
m("x", "<enter>", [[y/\V<C-r>=escape(@",'/\')<CR><CR>]], silent)
m("n", "<enter>", [[y/\V<C-r>=escape(@",'/\')<CR><CR>]], silent)

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
m("n", "/", [[ms/\v]], options)
m("x", "/", [[ms/\v]], options)
m("n", "?", [[ms?\v]], options)
m("x", "?", [[ms?\v]], options)
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
m("i", "<c-c>", "<nop>", {})
m("i", "<c-c>", [[coc#refresh()]], {silent = true, expr = true, noremap = true})
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
-- m("n", "<leader>s", "]s1z=", silent )

-- vimwiki
vim.g.vimwiki_key_mappings = {
  all_maps = 1,
  global = 0,
  headers = 1,
  text_objs = 0,
  table_format = 1,
  table_mappings = 1,
  lists = 1,
  links = 1,
  html = 0,
  mouse = 0
}

-- m("n", [[\wa]], [[<Plug>Vimwiki2HTMLBrowse]], {})
-- m("n", [[\wb]], [[<Plug>VimwikiRenameFile]], {})
-- m("n", [[\wc]], [[<Plug>VimwikiDiaryIndex]], {})
-- m("n", [[\wd]], [[<Plug>VimwikiDeleteFile]], {})
-- m("n", [[\we]], [[<Plug>VimwikiTabIndex]], {})
-- m("n", [[\wf]], [[<Plug>VimwikiUISelect]], {})
-- m("n", [[\wg]], [[<Plug>VimwikiIndex]], {})
-- m("n", [[\wh]], [[<Plug>Vimwiki2HTML]], {})
-- m("n", [[\wj]], [[<Plug>VimwikiMakeYesterdayDiaryNote]], {})
-- m("n", [[\wk]], [[<Plug>VimwikiMakeTomorrowDiaryNote]], {})
-- m("n", [[\wl]], [[<Plug>VimwikiDiaryGenerateLinks]], {})
-- m("n", [[\wm]], [[<Plug>VimwikiTabMakeDiaryNote]], {})
-- m("n", [[\wn]], [[<Plug>VimwikiMakeDiaryNote]], {})

-- n  <Tab>        @<Plug>VimwikiNextLink
-- v  <CR>         @<Plug>VimwikiNormalizeLinkVisualCR
-- n  <CR>         @<Plug>VimwikiFollowLink

-- shellcode
m(
  "x",
  "<space>h",
  [[:s/\v\s+//ge<cr><bar> :s/\v(..)/\\\x\1/ge<cr><bar> :s/\v.*/buffer \+\= b"&"/ge<cr>:noh<cr>]],
  silent
)

m("n", "<leader>s", [[]s1z=]], options)

-- nnoremap <leader>s ]s1z=

-- " remove any spaces and un-hexify (visual select)
-- xnoremap <silent>\h :s/\v\s+//ge<cr><bar> :s/\v\\x//ge<cr> :noh<cr>

-- " remove any spaces/shellcode
-- xnoremap <silent><leader>s ^ :s/\v\s+//ge<cr><bar> :noh<cr>
