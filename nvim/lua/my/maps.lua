local m = vim.api.nvim_set_keymap
local silent = { noremap = true, silent = true }

--- miniyank ---
-- m("n", "p", [[<Plug>(miniyank-autoput)]], {})
-- m("n", "P", [[<Plug>(miniyank-autoPut)]], {})

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
