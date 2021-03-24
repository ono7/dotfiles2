-- auto install paq if not exists

local cmd, fn, g = vim.cmd, vim.fn, vim.g

local install_path = fn.stdpath("data") .. "/site/pack/paqs/opt/paq-nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  cmd("!git clone https://github.com/savq/paq-nvim.git " .. install_path)
  vim.api.nvim_exec([[autocmd VimEnter * PaqInstall]], false)
end

-- setup paq
cmd "packadd paq-nvim"
local paq = require "paq-nvim".paq

-- plugins
paq {"savq/paq-nvim", opt = true}
paq "vimwiki/vimwiki"
paq {"neoclide/coc.nvim", branch = "release"}
-- paq "ervandew/supertab"
paq "christoomey/vim-tmux-navigator"
paq "tpope/vim-eunuch"
paq "tpope/vim-markdown"
-- paq "tpope/vim-repeat"
paq "tpope/vim-surround"
paq "jiangmiao/auto-pairs"
paq "nvim-treesitter/nvim-treesitter"
-- paq "nvim-treesitter/playground"
paq "lukas-reineke/format.nvim"
paq "SirVer/ultisnips"
paq "dense-analysis/ale"
paq "bfredl/nvim-miniyank"
paq "junegunn/fzf"
paq "junegunn/fzf.vim"
paq "kyazdani42/nvim-web-devicons"
paq "kyazdani42/nvim-tree.lua"
paq "Glench/Vim-Jinja2-Syntax"
paq "f-person/git-blame.nvim"
paq "b3nj5m1n/kommentary"

-- after plugins
require "pkg_config"

cmd "filetype plugin indent on"
