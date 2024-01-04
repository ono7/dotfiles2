--- locals ---
local o = vim.o
local opt = vim.opt
local wo = vim.wo
local bo = vim.bo


--- global options ---
o.completeopt = "menu,menuone,noinsert"
o.foldmethod = "indent"
o.mouse = "n"
o.grepprg = "git grep -n"
-- local is_ssh = os.getenv("SSH_CLIENT") or os.getenv("SSH_CONNECTION")
-- if is_ssh then
--   vim.opt.mouse = ""
-- end
o.spellsuggest = "best,5"
o.title = false
o.colorcolumn = "99999" -- fixes indentline?
o.directory = "~/.tmp"
o.undodir = os.getenv("HOME") .. "/.nvim_undo"
o.undofile = true
o.swapfile = false
o.smartcase = true
o.showbreak = [[↪ ]]

--- status line area ---
o.laststatus = 0
o.showmode = true
o.cmdheight = 1

opt.fillchars:append("stl: ")
opt.cursorline = true
o.cursorcolumn = false
o.cursorlineopt = "number"
o.hlsearch = false
o.incsearch = true
o.ignorecase = true
o.diffopt = "filler"
o.hidden = true
o.magic = true
o.joinspaces = false
o.showcmd = false
o.writebackup = false
o.history = 1000
o.ruler = true
o.scrolloff = 8
o.sidescrolloff = 20
opt.splitright = true
opt.splitbelow = false
-- opt.winbar = "%=%M %-.45f"
opt.iskeyword:append("-")
-- opt.iskeyword:append('"') -- have vim skip over ", when using w or b
o.smartcase = true
o.smarttab = true

-- whichwrap: "<>[]hl" allow hl to move past end of line when moving
vim.opt.whichwrap:append "<>[]"
-- opt.jumpoptions = "stack"
opt.jumpoptions:append("view")
o.inccommand = "nosplit"
o.foldopen = "hor,mark,percent,quickfix,search,tag,undo" -- removed 'block'
o.winaltkeys = "no"
o.pumheight = 10
-- o.pumblend = 3
o.emoji = false
-- o.redrawtime = 10000
o.lazyredraw = false
o.timeout = false -- remove timeout for partially typed commands
-- o.updatetime = 50
o.updatetime = 500
o.fillchars = [[diff:╱,vert:│,eob: ,msgsep:‾]]
o.listchars = [[tab:  ,trail:•,nbsp:·,conceal: ]]
o.nrformats = "bin,hex,alpha"
o.nrformats = "bin,hex"
-- o.shortmess = "aoOTtIsc"
o.shortmess = "aoOstTWICcF" -- F dont show file info when editing file, useful when statusline is enabled already
o.wildignore = [[.tags,tags,vtags,*.o,*.obj,*.rbc,*.pyc,__pycache__/*,.git,.git/*,*.class]]
o.tags = [[./tags,tags;~]]  -- search upwards until ~ (homedir)
o.showmatch = false
o.showtabline = 0
o.matchtime = 0
o.ttimeout = true -- disable for indefinite wait time
o.timeoutlen = 300
o.ttimeoutlen = 0
o.maxmempattern = 20000
o.wrapscan = true
o.breakindent = true
opt.isfname:append("@-@")


-- if vim.fn.has("wsl") == 1 then
--   vim.g.clipboard = ""
-- else
--   vim.g.clipboard = ""
--   opt.clipboard:append("unnamedplus")
-- end

opt.clipboard:append("unnamedplus")

-- local paste_prg = "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe"
-- local copy_prg = "/mnt/c/Windows/System32/clip.exe"
-- vim.g.clipboard = {
--   name = 'WslClipboard',
--   copy = {
--     ['+'] = copy_prg,
--     ['*'] = copy_prg,
--   },
--   paste = {
--     ['+'] = paste_prg .. ' -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--     ['*'] = paste_prg .. ' -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--   },
--   cache_enabled = 0,
-- }



-- o.virtualedit="all"

-- if vim.fn.executable("rg") == 1 then
--   o.grepformat = [[%f:%l:%c:%m,%f:%l:%m,%f:%l%m,%f  %l%m]]
--   -- o.grepprg = [[rg --vimgrep --no-heading --smart-case --color=never -g '!.git' 1>/dev/null]]
--   o.grepprg = [[rg --vimgrep --no-heading --smart-case --color=never -g '!.git']]
-- else
--   o.grepprg = [[grep -n $* /dev/null]]
--   o.grepformat = [[%f:%l:%m,%f:%l%m,%f  %l%m]]
-- end

--- window-local options ---
wo.number = false
wo.relativenumber = false
wo.wrap = false
wo.numberwidth = 2
wo.signcolumn = "yes"
wo.foldenable = false
wo.foldnestmax = 3
wo.foldlevel = 0
wo.list = true

--- buffer-local options ---
bo.autoread = true
bo.synmaxcol = 0
bo.swapfile = false
bo.shiftwidth = 2
bo.softtabstop = 2
bo.tabstop = 2
bo.textwidth = 80
bo.expandtab = true
bo.spelllang = "en_us"
vim.o.spellsuggest = 'best,9'

vim.opt.smartindent = true
vim.opt.autoindent = true

-- bo.complete = ".,w,b,u,kspell"
bo.complete = ".,w,b,u"
bo.formatoptions = "qlj" -- TODO: overwritten in my_cmds.lua
-- bo.matchpairs = "(:),{:},[:]"

vim.g.floating_window_border = {
  "╭",
  "─",
  "╮",
  "│",
  "╯",
  "─",
  "╰",
  "│",
}
