-- Follow the white rabbit...

-- command of the day gi, zi (fold enable toggle), X delete left
local cmd, g, m = vim.cmd, vim.g, vim.api.nvim_set_keymap
local xpr = {noremap = true, expr = true}
local opt = {noremap = true}
local silent = {noremap = true, silent = true}
local MYHOME = os.getenv("HOME")
local PRJCTAG = os.getenv("PRJCTAG")

g.loaded_gzip = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_zipPlugin = 1
g.loaded_2html_plugin = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_matchit = 1
g.loaded_spec = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1
g.loaded_tarPlugin = 1
g.loaded_spellfile_plugin = 1
g.loaded_remote_plugins = 1

--- provider settings ---
g.python_host_skip_check = 1
g.python2_host_skip_check = 1
g.python3_host_skip_check = 1
g.loaded_python_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.python3_host_prog = MYHOME .. "/.virtualenvs/prod3/bin/python3"

--- hold my beer ---

if PRJCTAG ~= nil then
  vim.o.tags = PRJCTAG .. [[,tags,vtags]]
else
  vim.o.tags = [[./tags,tags,.tags,vtags,.vtags]]
end

--- map leader ---
g.mapleader = ";"

m("n", "<Space>", "", {})

vim.o.path = vim.o.path .. "**"

-- nop
m("n", "<c-z>", "", opt)
m("c", "<c-z>", "", opt)
m("n", "ZZ", "", opt)
m("n", "ZQ", "", opt)

-- m("n", "<c-[>", "<cmd>noh<cr>1<c-g>", silent)
m("n", "<Esc>", "<cmd>noh<cr>1<c-g>", silent)
m("n", "yw", "yiw", silent)
m("n", "gi", "gi<c-o>zz", silent)
m("n", "gp", "`[v`]", silent)
m("n", "Q", "@q", opt)
m("n", "<leader>d", ":bd!<cr>1<c-g>", silent)
m("n", "<leader>q", ":qall!<cr>", silent)
m("n", "<leader>w", [[:call v:lua.pre_write()<cr>]], silent)
m("n", "Y", "y$", opt)
m("n", 'y"', 'yi"', opt)
m("n", "y'", "yi'", opt)
m("n", "D", "d$", opt)
m("n", "cp", "yap<S-}>p", opt)
m("n", "U", "<c-r>", opt)

-- correct spelling @word
m("n", "zz", [[zz msz=1<CR><CR>`s]], silent)

-- swap visual bindings
m("n", "v", "<C-V>", opt)
m("n", "<C-V>", "v", opt)
m("v", "v", "<C-V>", opt)
m("v", "<C-V>", "v", opt)

m("c", "<c-a>", "<Home>", opt)
m("c", "<c-h>", "<Left>", opt)
m("c", "<c-l>", "<Right>", opt)

m("v", "y", "mxy`x", opt)
m("v", "Q", ":'<,'>norm @q<cr>", silent)

m("i", "<c-e>", "<c-o>$", silent)
m("i", "<c-a>", "<c-o>^", silent)
m("i", "<m-b>", "<c-o>B", silent)
m("i", "<m-f>", "<c-o>W", silent)
m("n", "<c-a>", "^", opt)
m("n", "<c-e>", "g_", opt)
m("v", "<c-e>", "g_", opt)

m("i", "`", "``<left>", opt)
m("i", "(", "()<left>", opt)
m("i", "{", "{}<left>", opt)
m("i", "[", "[]<left>", opt)
m("i", "<c-d>", "<cr><esc>O", opt)
m("i", ")", [[strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"]], xpr)
m("i", "}", [[strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"]], xpr)
m("i", "]", [[strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"]], xpr)
m("i", "'", [[strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"]], xpr)
m("i", '"', [[strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"]], xpr)
-- m("i", "{;<cr>", "{<cr>};<esc>O", opt)

cmd [[ command! Ctags exec 'silent !ctags -R --exclude=.git .' ]]

g.ale_disable_lsp = 1

function _G.pre_write()
  vim.bo.expandtab = true
  do
    cmd [[let old = @/]]
    cmd "%retab!"
    cmd [[%s/\s\+$//e]]
    cmd [[let @/ = old]]
  end
  if g.loaded_format == 1 then
    cmd "keepjumps FormatWrite!"
  end
  cmd "keepjumps update"
  cmd "noh"
  -- cmd [[:silent !git add %]]
end

cmd "syntax enable"
cmd "set synmaxcol=512"
cmd "syntax sync minlines=256"
cmd "syntax sync maxlines=300"
cmd "syntax on"

function _G.mySyntax()
  cmd [[syntax match myRed /[:,.]/]]
  cmd [[syntax match myCyan /[=<!>-]/ ]]
  cmd [[syntax match myYellow /[*{}]/ ]]
  cmd [==[syntax match myBlue /[\[\]()]/]==]
end

function _G.legacy()
  -- :lua legacy()
  vim.api.nvim_paste(require("extra_vars").legacy_cfg, "", -1)
end

function _G.perflog()
  cmd [[profile start ~/profile.log]]
  cmd [[profile func *]]
  cmd [[profile file *]]
end

require "onedark".setup {}
-- cmd [[colorscheme base16-onedark]]
cmd "hi!  snipLeadingSpaces  ctermbg=0  guibg=none  guifg=none"

require "my_maps"
require "my_vars"
require "my_settings"
require "my_pkg"
require "my_snips"
require "my_lsp_compe"
require "my_cmds"

if vim.opt.diff:get() then
  vim.wo.signcolumn = "no"
  vim.wo.foldcolumn = "0"
  vim.wo.numberwidth = 1
  vim.wo.number = true
  vim.o.cmdheight = 1
  -- vim.o.diffopt = "filler,internal,algorithm:patience" -- no context, new algo
  -- vim.o.diffopt = "filler,context:0,internal,algorithm:patience,indent-heuristic"
  vim.o.diffopt = "filler,context:0,internal,algorithm:histogram,indent-heuristic"
  -- set diffopt+=iwhite -- ignore white space during diff
  m("n", "]", "]c", opt)
  m("n", "[", "[c", opt)
end

--[[

  npm install lua-fmt prettier pyright -g
  pip install black pylint yamllint

  echo system('base64 -d', @")
  :<c-f> (command search)

  insert mode, <c-r> =   system('date'), or 2+2
    -- Lima

--]]
