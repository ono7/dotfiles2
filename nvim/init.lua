-- Follow the white rabbit...

local cmd, g = vim.cmd, vim.g

-- disable ale before plugins are loaded
g.ale_disable_lsp = 1

g.mapleader = " "
-- g.vimsyn_embed = "l"

local utils = require "utils"

-- providers
g.python_host_skip_check = 1
g.python2_host_skip_check = 1
g.python3_host_skip_check = 1
g.python3_host_prog = utils.home .. "/.virtualenvs/prod3/bin/python3"
g.loaded_python_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- highlight yanked text for 250ms
cmd [[au TextYankPost * silent! lua vim.highlight.on_yank{ timeout = 75 }]]

-- hold my beer
require "pkg"
require "keymaps"
require "settings"
require "autocmds"
require "vars"

-- color and syntax related
cmd "colorscheme onehalfdark"
cmd "syntax enable"
cmd "syntax sync minlines=256"
cmd "syntax sync maxlines=300"
cmd "syntax on"
