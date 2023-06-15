local c = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local mygrp = augroup("mygrp", { clear = true })
local yank_group = augroup("HighlightYank", {})

c("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "Visual",
      timeout = 40,
    })
  end,
})

-- resize windows
c({ "VimResized" }, { pattern = "*", command = [[:wincmd =]], group = mygrp })

-- restore cursor position on enter
vim.api.nvim_create_autocmd("BufRead", {
  callback = function(opts)
    vim.api.nvim_create_autocmd("BufWinEnter", {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if
            not (ft:match("commit") and ft:match("rebase"))
            and last_known_line > 1
            and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
        then
          vim.api.nvim_feedkeys([[g`"]], "x", false)
        end
      end,
    })
  end,
  group = mygrp,
})

-- set my fo options
-- 2023-04-05 disabled... testing

c({ "BufEnter" }, { pattern = "*.go", command = [[:LspStart]], group = mygrp })

c("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  group = mygrp,
  desc = "Disable New Line Comment",
})

-- c({"Syntax"}, {pattern = "*", command = "syntax sync minlines=200", group = mygrp })

-- remap enter in quickfix
c({ "BufReadPost" }, { pattern = "quickfix", command = [[map <buffer> <CR> <CR> ]], group = mygrp })

-- handle large files, syntax=OFF only affects buffer, where syntax off is global
-- syn sync clear, we can keep syntax and still work on large files!
c({
  "BufWinEnter",
}, {
  pattern = "*",
  command =
  [[if line2byte(line("$") + 1) > 800000 | syn sync clear | setlocal nowrap noundofile noswapfile foldmethod=manual | endif]],
  group = mygrp,
})

-- auto source snippets file
c("BufWritePost", {
  pattern = "*.snippet",
  command = [[:SnippyReload<CR>]],
  group = mygrp,
})

-- auto create dirs when saving files
c("BufWritePre", {
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(ctx)
    vim.fn.mkdir(vim.fn.fnamemodify(ctx.file, ":p:h"), "p")
  end,
})

-- auto create dirs when saving files
c("BufWritePre", {
  group = vim.api.nvim_create_augroup("write_and_clean_empty_lines", { clear = true }),
  command = [[:%s#\($\n\s*\)\+\%$##e]]
})

c({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("clear_trailing_spaces", { clear = true }),
  pattern = { "*.py", "*.yml", "*.cfg", "*.sh", "*.j2", "*.snippets", "*.lua"},
  callback = function()
    local save_cursor = vim.fn.getcurpos()
    vim.cmd([[silent! %s/\s\+$//e]])
    vim.fn.setpos('.', save_cursor)
  end,
})

c({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("terraform", { clear = true }),
  pattern = { "*.tf", "*.tfvars" },
  callback = function()
    vim.lsp.buf.format()
  end,
})

c("FocusGained", {
  callback = function()
    vim.cmd("checktime")
  end,
  group = mygrp,
  desc = "Update file when there are changes",
})

c("ModeChanged", {
  callback = function()
    if vim.fn.getcmdtype() == "/" or vim.fn.getcmdtype() == "?" then
      vim.opt.hlsearch = true
    else
      vim.opt.hlsearch = false
    end
  end,
  group = mygrp,
  desc = "Highlighting matched words when searching",
})

c("TermOpen", {
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.cmd("startinsert!")
  end,
  -- group = augroup,
  desc = "Terminal Options",
})

-- adapted from https://github.com/ethanholz/nvim-lastplace/blob/main/lua/nvim-lastplace/init.lua
local ignore_buftype = { "quickfix", "nofile", "help" }
local ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" }

local function run()
  if vim.tbl_contains(ignore_buftype, vim.bo.buftype) then
    return
  end

  if vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
    -- reset cursor to first line
    vim.cmd[[normal! gg]]
    return
  end

  -- If a line has already been specified on the command line, we are done
  --   nvim file +num
  if vim.fn.line(".") > 1 then
    return
  end

  local last_line = vim.fn.line([['"]])
  local buff_last_line = vim.fn.line("$")

  -- If the last line is set and the less than the last line in the buffer
  if last_line > 0 and last_line <= buff_last_line then
    local win_last_line = vim.fn.line("w$")
    local win_first_line = vim.fn.line("w0")
    -- Check if the last line of the buffer is the same as the win
    if win_last_line == buff_last_line then
      -- Set line to last line edited
      vim.cmd[[normal! g`"]]
      -- Try to center
    elseif buff_last_line - last_line > ((win_last_line - win_first_line) / 2) - 1 then
      vim.cmd[[normal! g`"zz]]
    else
      vim.cmd[[normal! G'"<c-e>]]
    end
  end
end

vim.api.nvim_create_autocmd({'BufWinEnter', 'FileType'}, {
  group    = vim.api.nvim_create_augroup('nvim-lastplace', {}),
  callback = run
})
