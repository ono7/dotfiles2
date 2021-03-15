local o = vim.o
local wo = vim.wo
local bo = vim.bo

-- set formatoptions+=n
-- vim.o.formatoptions = vim.o.formatoptions .. 'n'
-- 
-- set formatoptions-=n
-- vim.o.formatoptions = string.gsub(vim.o.formatoptions, 'n', '')
--
-- global options
o.termguicolors = true
o.cmdheight = 2
o.swapfile = true
o.dir = "/tmp"
o.smartcase = true
o.laststatus = 0
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
-- ... snip ...

-- window-local options
wo.number = false
wo.wrap = false

-- buffer-local options
bo.expandtab = true
bo.autoindent = true
bo.autoread = true
bo.synmaxcol= 0
