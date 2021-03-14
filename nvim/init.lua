-- Follow the white rabbit...

local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local indent = 2

require("settings")
require("keymaps")
require("utils")

cmd "colorscheme onehalfdark"
cmd "syntax enable"
cmd "syntax sync minlines=256"
cmd "syntax sync maxlines=300"
cmd "syntax on"

g.mapleader = " "
g.vimsyn_embed = "l"

-- Auto install paq if not exists
local install_path = fn.stdpath("data") .. "/site/pack/paqs/opt/paq-nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  cmd("!git clone https://github.com/savq/paq-nvim.git " .. install_path)
end

vim.cmd 'packadd paq-nvim'         -- Load package
local paq = require'paq-nvim'.paq  -- Import module and bind `paq` function
paq{'savq/paq-nvim', opt=true}     -- Let Paq manage itself

paq 'ervandew/supertab'
paq 'christoomey/vim-tmux-navigator'
paq 'tpope/vim-commentary'
paq 'tpope/vim-eunuch'

-- Plug 'jiangmiao/auto-pairs'
-- Plug 'Glench/Vim-Jinja2-Syntax', { 'for' : 'jinja' }
-- Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
-- Plug 'junegunn/fzf.vim'
-- Plug 'tpope/vim-surround'
-- Plug 'tpope/vim-repeat'
-- Plug 'tpope/vim-markdown', {'for' : 'markdown'}
-- Plug 'scrooloose/nerdtree',{ 'on': ['NERDTreeToggle', 'NERDTree', 'NERDTreeFind', 'NERDTreeClose'] }
-- Plug 'vimwiki/vimwiki'


