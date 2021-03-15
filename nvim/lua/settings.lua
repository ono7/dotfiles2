local o = vim.o
local wo = vim.wo
local bo = vim.bo

-- set formatoptions+=n
-- vim.o.formatoptions = vim.o.formatoptions .. 'n'
-- 
-- set formatoptions-=n
-- vim.o.formatoptions = string.gsub(vim.o.formatoptions, 'n', '')

--- global options
o.termguicolors = true
o.cmdheight = 2
o.directory="~/.tmp"
o.swapfile = true
o.smartcase = true
o.laststatus = 0
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.completeopt = string.gsub(o.completeopt, 'preview', '')
o.diffopt='filler'
o.hidden=true
o.magic=true
o.list = true
o.joinspaces=false
o.showcmd=false
o.writebackup=false
o.history = 999
o.ruler=true
o.scrolloff=2
o.sidescrolloff=1
o.matchtime=0
o.splitbelow=true
o.smartcase=true 
o.smarttab=true
o.shiftround=true
o.inccommand="nosplit"
o.winaltkeys="no"
o.pumheight=10 
o.pumblend=0
o.redrawtime=10000
o.lazyredraw=true
o.timeout=true
o.timeoutlen=500
o.updatetime=250

-- window-local options
wo.number = false
wo.wrap = false
wo.numberwidth=2
wo.signcolumn='yes'
wo.foldenable=false

-- buffer-local options
bo.expandtab = true
bo.autoindent = true
bo.autoread = true
bo.synmaxcol= 0
bo.swapfile=false
bo.shiftwidth=2
bo.softtabstop=2 
bo.tabstop=2 
bo.textwidth=80 
bo.expandtab=true
bo.spelllang='en_us'

-- set complete+=kspell complete-=i complete-=t
-- set fillchars+=vert:│
-- set listchars=tab:→\ ,trail:·,nbsp:•
-- set nrformats-=octal nrformats+=alpha
-- set pastetoggle=<F2>
-- set shortmess+=c
-- set shortmess=atIoOsT
-- set wildignore+=*.o,*.obj,*.rbc,*.pyc,__pycache__/*,.git,.git/*

