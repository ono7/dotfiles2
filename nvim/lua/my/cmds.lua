local c = vim.api.nvim_create_autocmd
local create_augroup = vim.api.nvim_create_augroup

c("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "Visual",
      timeout = 40,
    })
  end,
  group = create_augroup("highlight_yanked_text", { clear = true }),
})

-- Turn off diagnostics for .env files
c({ "BufRead", "BufNewFile" }, {
  pattern = ".env",
  group = create_augroup("dotenv_disabled_diagnostics", { clear = true }),
  callback = function(context)
    vim.diagnostic.disable(context.buf)
  end,
})

-- Check if we need to reload the file when it changed
c({ "FocusGained", "TermClose", "TermLeave" }, {
  pattern = "*",
  group = create_augroup("checktime", { clear = true }),
  command = "checktime",
})

-- resize windows
c({ "VimResized" }, {
  pattern = "*",
  command = [[:wincmd =]],
  group = create_augroup("vim_resize_windows_automatically", { clear = true }),
})

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
  group = create_augroup("restore_cursor_position_on_enter", { clear = true }),
})

-- c("BufWritePre", {
--   pattern = { "*.go" },
--   callback = function()
--
--     local save_cursor = vim.fn.getcurpos()
--     local params = vim.lsp.util.make_range_params(nil, "utf-16")
--     params.context = { only = { "source.organizeImports" } }
--     local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
--     for _, res in pairs(result or {}) do
--       for _, r in pairs(res.result or {}) do
--         if r.edit then
--           vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
--         else
--           vim.lsp.buf.execute_command(r.command)
--         end
--       end
--     end
--     vim.fn.setpos('.', save_cursor)
--   end,
-- })

c("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  group = create_augroup("remove_format_options", { clear = true }),
  desc = "Disable New Line Comment",
})
-- AUTO-COMMANDS:
c({ "BufNewFile", "BufRead" }, {
  pattern = { "static/html", "static/pico", "**/node_modules/**", "node_modules", "/node_modules/*" },
  callback = function()
    vim.diagnostic.disable(0)
  end,
  group = create_augroup("disable_lsp_diags_for_folders", { clear = true }),
})

-- remap enter in quickfix
c({ "BufReadPost" }, {
  pattern = "quickfix",
  command = [[map <buffer> <CR> <CR> ]],
  group = create_augroup("set_quickfix_maps", { clear = true }),
})

-- handle large files, syntax=OFF only affects buffer, where syntax off is global
-- syn sync clear, we can keep syntax and still work on large files! 2023-09-23, probably not needed with treesitter
-- c({
--   "BufWinEnter",
-- }, {
--   pattern = "*",
--   command =
--   [[if line2byte(line("$") + 1) > 800000 | syn sync clear | setlocal nowrap noundofile noswapfile foldmethod=manual | endif]],
--   group = create_augroup("check_if_file_size_too_big", { clear = true }),
-- })

-- auto source snippets file
c("BufWritePost", {
  pattern = "*.snippet",
  command = [[:SnippyReload<CR>]],
  group = create_augroup("reload_snippets", { clear = true }),
})

-- auto create dirs when saving files
c("BufWritePre", {
  group = create_augroup("auto_create_dir", { clear = true }),
  callback = function(ctx)
    vim.fn.mkdir(vim.fn.fnamemodify(ctx.file, ":p:h"), "p")
  end,
})

c("BufWritePre", {
  group = create_augroup("write_and_clean_empty_lines", { clear = true }),
  pattern = { "*" },
  callback = function()
    local save_cursor = vim.fn.getcurpos()
    vim.cmd [[:%s#\($\n\s*\)\+\%$##e]]
    vim.fn.setpos('.', save_cursor)
  end,
})

c({ "BufWritePre" }, {
  group = create_augroup("clear_trailing_spaces", { clear = true }),
  pattern = { "*.tf", "*.tfvars", "*.nasm", "*.js", "*.py", "*.yml", "*.cfg", "*.sh", "*.j2", "*.snippets", "*.lua" },
  callback = function()
    local save_cursor = vim.fn.getcurpos()
    vim.cmd([[silent! %s/\s\+$//e]])
    vim.fn.setpos('.', save_cursor)
  end,
})

c({ "BufWritePre" }, {
  group = create_augroup("all_files", { clear = true }),
  -- pattern = { "*.tf", "*.tfvars" },
  pattern = { "*.*" },
  callback = function()
    vim.lsp.buf.format()
  end,
})

c("FocusGained", {
  callback = function()
    vim.cmd("checktime")
  end,
  group = create_augroup("update_file_when_changes_detected", { clear = true }),
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
  group = create_augroup("clear_hl_highlight_on_search", { clear = true }),
  desc = "Highlighting matched words when searching",
})

c("TermOpen", {
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.cmd("startinsert!")
  end,
  group = create_augroup("set_buf_number_options", { clear = true }),
  desc = "Terminal Options",
})
