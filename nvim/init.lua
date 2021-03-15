-- Follow the white rabbit...

local cmd, fn, g = vim.cmd, vim.fn, vim.g

-- disable ale before plugins are loaded
g.ale_disable_lsp = 1

-- providers
g.python3_host_prog = os.getenv("HOME") .. "/.virtualenvs/prod3/bin/python3"
g.loaded_python_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- hold my beer
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

g.mapleader = " "
g.vimsyn_embed = "l"

-- highlight yanked text for 250ms
cmd [[au TextYankPost * silent! lua vim.highlight.on_yank{ timeout = 75 }]]

-- auto install paq if not exists
local install_path = fn.stdpath("data") .. "/site/pack/paqs/opt/paq-nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  cmd("!git clone https://github.com/savq/paq-nvim.git " .. install_path)
end

-- setup paq
cmd "packadd paq-nvim"
local paq = require "paq-nvim".paq

-- plugins
paq {
  "savq/paq-nvim",
  opt = true
}
paq "ervandew/supertab"
paq "christoomey/vim-tmux-navigator"
paq "tpope/vim-commentary"
paq "tpope/vim-eunuch"
paq "tpope/vim-markdown"
paq "tpope/vim-repeat"
paq "tpope/vim-surround"
paq "jiangmiao/auto-pairs"
paq "nvim-treesitter/nvim-treesitter"
paq "lukas-reineke/format.nvim"
paq "SirVer/ultisnips"
paq "dense-analysis/ale"
paq {
  "neoclide/coc.nvim",
  branch = "release"
}

-- paq "Glench/Vim-Jinja2-Syntax"

-- after plugins
require "package_setup"

-- Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
-- Plug 'junegunn/fzf.vim'
-- Plug 'scrooloose/nerdtree',{ 'on': ['NERDTreeToggle', 'NERDTree', 'NERDTreeFind', 'NERDTreeClose'] }
-- Plug 'vimwiki/vimwiki'
