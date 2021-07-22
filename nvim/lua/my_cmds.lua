local function nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command("augroup " .. group_name)
    vim.api.nvim_command("autocmd!")
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten {"autocmd", def}, " ")
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command("augroup END")
  end
end

local autocmds = {
  _init = {
    {
      -- handle large files
      "BufWinEnter",
      "*",
      [[if line2byte(line("$") + 1) > 800000 | syntax clear | setlocal nowrap | setlocal eventignore=all | endif ]]
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
      -- restore cursor position on enter
      "BufReadPost",
      "*",
      [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]]
    },
    {"BufEnter", "*", [[set formatoptions=qnlj]]},
    {"BufReadPost", "quickfix", [[nnoremap <buffer> <CR> <CR>]]}
  },
  _set_type = {
    {"BufNewFile,BufRead,BufEnter", "*.asm,*.nasm", [[setfiletype nasm]]},
    {"BufNewFile,BufRead,BufEnter", "*.md", [[setfiletype markdown]]}
  },
  _yank_hl = {
    {"TextYankPost", "*", [[silent! lua require'vim.highlight'.on_yank({higroup='Cursor', timeout = 50})]]}
  },
  _terminal = {
    {"TermEnter", "*", [[setlocal scrolloff=0]]},
    {"TermLeave", "*", [[setlocal scrolloff=1]]}
  },
  _def_space = {
    {"FileType", "python", [[setlocal sw=4 ts=4 et softtabstop=4 tw=0 nowrap autoindent indentexpr=]]},
    {"FileType", "*", [[setlocal sw=2 ts=2 et softtabstop=2 tw=0 nowrap autoindent]]}
  }
}

nvim_create_augroups(autocmds)
