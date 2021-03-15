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
    {"BufWritePost", "*", [[FormatWrite]]}
  }
}

-- vim.api.nvim_command([[
-- augroup init
--   autocmd!
--   autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | setlocal nowrap | setlocal eventignore=all | endif
--   autocmd VimEnter * command! -bang -nargs=? GFiles call fzf#vim#gitfiles(<q-args>, {'options': '--no-preview'}, <bang>0)
--   autocmd VimEnter * command! -bang -nargs=? Files call fzf#vim#files(<q-args>, {'options': '--no-preview'}, <bang>0)
-- augroup END
-- ]])

nvim_create_augroups(autocmds)
