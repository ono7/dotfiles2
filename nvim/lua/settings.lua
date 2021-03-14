local o = vim.o
local wo = vim.wo
local bo = vim.bo

-- global options
o.cmdheight = 2
o.swapfile = true
o.dir = "/tmp"
o.smartcase = true
o.laststatus = 2
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.scrolloff = 12
-- ... snip ...

-- window-local options
wo.number = false
wo.wrap = false

-- buffer-local options
bo.expandtab = true
bo.autoindent = true
bo.autoread = true
