-- vim.api.nvim_command([[
-- augroup init
--   autocmd!
--   autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | setlocal nowrap | setlocal eventignore=all | endif
--   autocmd VimEnter * command! -bang -nargs=? GFiles call fzf#vim#gitfiles(<q-args>, {'options': '--no-preview'}, <bang>0)
--   autocmd VimEnter * command! -bang -nargs=? Files call fzf#vim#files(<q-args>, {'options': '--no-preview'}, <bang>0)
-- augroup END
-- ]])

vim.api.nvim_command([[
augroup ResizeVim
autocmd!
autocmd VimResized * :wincmd =
augroup END
]])

-- vim.api.nvim_command([[
-- augroup _read
--   autocmd!
--   " restore last known position
--   autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
--   autocmd BufEnter * silent! lcd %:p:h
-- augroup END
-- ]])

-- vim.api.nvim_command([[
-- augroup _set_type
--   autocmd!
--   autocmd BufNewFile,BufRead,BufEnter *.asm,*.nasm setfiletype nasm
--   " autocmd BufNewFile,BufRead,BufEnter *.yml,*.yaml setfiletype ansible.yaml
--   autocmd BufNewFile,BufRead,BufEnter *.wiki setfiletype vimwiki
--   autocmd BufNewFile,BufRead,BufEnter *.ejs setfiletype html
-- augroup END
-- ]])

-- -- vim.api.nvim_command([[
-- -- augroup _write
-- --   autocmd!
-- --   autocmd BufWritePre * silent! :call <SID>StripTrailingWhitespaces() | retab
-- --   " Plug 'lukas-reineke/format.nvim'
-- --   autocmd BufWritePost * FormatWrite
-- -- augroup END
-- -- ]])

-- vim.api.nvim_command([[
-- augroup _format_opts
--   autocmd!
--   autocmd FileType * set formatoptions-=cro fo+=j
-- augroup END
-- ]])
