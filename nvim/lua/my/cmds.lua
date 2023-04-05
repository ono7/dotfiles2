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
-- c({ "BufEnter" }, { pattern = "*", command = [[setlocal formatoptions=qnlj]], group = mygrp })

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
	command = [[if line2byte(line("$") + 1) > 800000 | syn sync clear | setlocal nowrap noundofile noswapfile foldmethod=manual | endif]],
	group = mygrp,
})

-- auto source snippets file
c("BufWritePost", {
	pattern = "snippet.lua",
	command = [[:luafile %]],
	group = mygrp,
})

-- auto create dirs when saving files
c("BufWritePre", {
	group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
	callback = function(ctx)
		vim.fn.mkdir(vim.fn.fnamemodify(ctx.file, ":p:h"), "p")
	end,
})

c({ "BufWritePre" }, {
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

-- autocmd("ModeChanged", {
--   callback = function()
--     if fn.getcmdtype() == "/" or fn.getcmdtype() == "?" then
--       vim.opt.hlsearch = true
--     else
--       vim.opt.hlsearch = false
--     end
--   end,
--   group = mygrp,
--   desc = "Highlighting matched words when searching",
-- })

-- remove this if there's an issue
-- c({ "BufReadPost", "BufNewFile" }, {
--   once = true,
--   callback = function()
--     if vim.fn.has "wsl" == 1 then
--       -- Set a compatible clipboard manager
--       vim.g.clipboard = {
--         copy = {
--           ["+"] = "win32yank.exe -i --crlf",
--           ["*"] = "win32yank.exe -i --crlf",
--         },
--         paste = {
--           ["+"] = "win32yank.exe -o --lf",
--           ["*"] = "win32yank.exe -o --lf",
--         },
--       }
--     end
--     vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
--   end,
--   group = augroup,
--   desc = "Lazy load clipboard",
-- })

c("TermOpen", {
	callback = function()
		vim.opt_local.relativenumber = false
		vim.opt_local.number = false
		vim.cmd("startinsert!")
	end,
	-- group = augroup,
	desc = "Terminal Options",
})
