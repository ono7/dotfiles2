--- locals ---
local o = vim.o
local wo = vim.wo
local bo = vim.bo

--- global options ---
o.completeopt = "menuone,noinsert,noselect"
o.foldmethod = "indent"
o.title = false
o.termguicolors = true
o.cmdheight = 2
o.directory = "~/.tmp"
o.swapfile = false
o.smartcase = true
o.laststatus = 0
o.hlsearch = false
o.incsearch = true
o.ignorecase = true
o.diffopt = "filler"
o.hidden = true
o.magic = true
o.joinspaces = false
o.showcmd = false
o.writebackup = false
o.history = 999
o.ruler = true
o.scrolloff = 0
o.sidescrolloff = 1
o.splitbelow = true
o.smartcase = true
o.smarttab = true
o.shiftround = true
o.inccommand = "nosplit"
o.winaltkeys = "no"
o.pumheight = 5
o.pumblend = 0
o.emoji = false
o.redrawtime = 10000
o.lazyredraw = true
o.timeout = true
o.timeoutlen = 500
o.updatetime = 250
o.fillchars = [[vert:│]]
o.listchars = [[tab:→\ ,trail:·,nbsp:•]]
o.nrformats = "bin,hex,alpha"
o.shortmess = "actIoOsT"
o.wildignore = [[*.o,*.obj,*.rbc,*.pyc,__pycache__/*,.git,.git/*]]
o.pastetoggle = [[<F2>]]
-- vim.g.loaded_matchparen = 0
o.showmatch = false
o.matchtime = 0
o.ttimeout = false
o.ttimeoutlen = 10
o.wrapscan = true
vim.g.myrg = 0

function _G.rg()
  if vim.g.myrg == 0 then
    o.grepformat = [[%f:%l:%c:%m,%f:%l:%m,%f:%l%m,%f  %l%m]]
    o.grepprg = [[rg --vimgrep]]
    vim.g.myrg = 1
  else
    o.grepprg = [[grep -n $* /dev/null]]
    o.grepformat = [[%f:%l:%m,%f:%l%m,%f  %l%m]]
    vim.g.myrg = 0
  end
end

--- window-local options ---
wo.number = false
wo.wrap = false
wo.numberwidth = 2
wo.signcolumn = "yes:1"
wo.foldenable = false
wo.list = true
wo.cursorline = false

--- buffer-local options ---
-- bo.autoindent = true
bo.autoread = true
bo.synmaxcol = 0
bo.swapfile = false
bo.shiftwidth = 2
bo.softtabstop = 2
bo.tabstop = 2
bo.textwidth = 80
bo.expandtab = true
bo.spelllang = "en_us"
bo.complete = ".,w,b,u,kspell"
bo.formatoptions = "qlj" -- this is what we need
-- bo.smartindent = true
