local map = vim.api.nvim_set_keymap

options = { noremap = true }

map('i', 'jk', '<esc><cmd>noh<cr><c-g>', options)

-- disable c-z (bg)
map('n', '<c-z>', '<nop>', options)
map('c', '<c-z>', '<nop>', options)

map('n', 'cp', 'yap<S-}>p', options)

-- macros

map('n', 'Q', '@q', options)
map('x', 'Q', ":'<,'>norm @q<cr>", options)

test
test
test


-- " macros
-- nnoremap Q @q
-- xnoremap Q :'<,'>norm @q<cr>
-- 
-- " create list from visual select and normal mode -> single line
-- " xnoremap <C-l> :s/\v\s+$//ge<cr>gv :s/\v^(.+)$/"\1",/ge<cr>gvJ :noh<cr>
-- 
-- nnoremap <leader>ve :e $MYVIMRC<cr>
-- nnoremap <leader>vr :source $MYVIMRC<cr>
-- 
-- inoremap jk <Esc>:noh<cr><c-g>
-- 
-- " move around line wraps
-- nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
-- nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
-- 
-- nnoremap <silent><leader>t :silent !tmux send-keys -t 2 c-p Enter<cr>
-- 
-- nnoremap H ^
-- nnoremap L g_
-- vnoremap H ^
-- vnoremap L g_
-- 
-- nnoremap U <C-r>
-- 
-- cnoremap w!! w !sudo tee % > /dev/null
-- cnoremap %s %s/\v
-- cnoremap %g %g/\v
-- cnoremap %v %v/\v
-- 
-- " improved jumps w/marks (marks go to col ' `)
-- nnoremap ' `
-- nnoremap / ms/\v
-- xnoremap / ms/\v
-- nnoremap ? ms?\v
-- xnoremap ? ms?\v
-- nnoremap gg msgg<c-g>
-- nnoremap G msG<c-g>
-- nnoremap gd msgd
-- nnoremap * ms*
-- nnoremap # ms#
-- 
-- nmap V Vg_
