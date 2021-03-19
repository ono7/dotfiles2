-- autocmd helper function

function nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command("augroup " .. group_name)
    vim.api.nvim_command("autocmd!")
    for _, def in ipairs(definition) do
      local command =
        table.concat(
        vim.tbl_flatten {
          "autocmd",
          def
        },
        " "
      )
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command("augroup END")
  end
end

local autocmds = {
  _init = {
    {
      "BufWinEnter",
      "*",
      [[if line2byte(line("$") + 1) > 1000000 | syntax clear | setlocal nowrap | let b:coc_enable = 0 | setlocal eventignore=all | endif ]]
    },
    {
      "VimEnter",
      "*",
      [[command! -bang -nargs=? GFiles call fzf#vim#gitfiles(<q-args>, {'options': '--no-preview'}, <bang>0)]]
    },
    {
      "VimEnter",
      "*",
      [[command! -bang -nargs=? Files call fzf#vim#files(<q-args>, {'options': '--no-preview'}, <bang>0)]]
    }
  },
  _resize = {
    {"VimResized", "*", [[:wincmd =]]}
  },
  _read = {
    {
      "BufReadPost",
      "*",
      [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]]
    },
    {"BufEnter", "*", [[silent! lcd %:p:h]]},
    {"BufEnter", "*", [[set formatoptions=qlj]]}
  },
  _set_type = {
    {"BufNewFile,BufRead,BufEnter", "*.asm,*.nasm", [[setfiletype nasm]]},
    {"BufNewFile,BufRead,BufEnter", "*.wiki", [[setfiletype vimwiki]]},
    {"BufNewFile,BufRead,BufEnter", "*.ejs", [[setfiletype html]]}
  },
  _write = {
    {"BufWritePre", "*", [[:call v:lua.pre_format()]]}
  }
}

nvim_create_augroups(autocmds)

-- this works too
-- vim.api.nvim_exec(
--   [[

-- augroup _init
--   autocmd!
--   autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | setlocal nowrap | setlocal eventignore=all | endif
--   autocmd VimEnter * command! -bang -nargs=? GFiles call fzf#vim#gitfiles(<q-args>, {'options': '--no-preview'}, <bang>0)
--   autocmd VimEnter * command! -bang -nargs=? Files call fzf#vim#files(<q-args>, {'options': '--no-preview'}, <bang>0)
-- augroup END

-- augroup _read
--   autocmd!
--   " restore last known position
--   autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
--   autocmd BufEnter * silent! lcd %:p:h
--   autocmd BufEnter * set formatoptions=qlj
-- augroup END

-- augroup _resize
--   autocmd!
--   " resize splits when terminal size changes
--   autocmd VimResized * :wincmd =
-- augroup END

-- augroup _write
--   autocmd!
--   autocmd BufWritePre * silent! retab
--   autocmd BufWritePost * FormatWrite
-- augroup END

-- augroup _set_type
--   autocmd!
--   autocmd BufNewFile,BufRead,BufEnter *.asm,*.nasm setfiletype nasm
--   " autocmd BufNewFile,BufRead,BufEnter *.yml,*.yaml setfiletype ansible.yaml
--   autocmd BufNewFile,BufRead,BufEnter *.wiki setfiletype vimwiki
--   autocmd BufNewFile,BufRead,BufEnter *.ejs setfiletype html
-- augroup END

-- ]],
--   false
-- )
