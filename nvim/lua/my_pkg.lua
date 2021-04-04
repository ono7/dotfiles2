-- auto install paq if not exists

local cmd, fn = vim.cmd, vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/paqs/opt/paq-nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  -- download and install if missing
  cmd("!git clone https://github.com/savq/paq-nvim.git " .. install_path)
  vim.api.nvim_exec([[autocmd VimEnter * PaqInstall]], false)
end

-- let paq-nvim manage it self

cmd "packadd paq-nvim"
local paq = require "paq-nvim".paq

paq {"savq/paq-nvim", opt = true}

-- plugins

paq "vimwiki/vimwiki"
paq "numToStr/Navigator.nvim"
paq "tpope/vim-eunuch"
paq "tpope/vim-markdown"
paq "tpope/vim-surround"
paq "tpope/vim-repeat"
paq "jiangmiao/auto-pairs"
paq "nvim-treesitter/nvim-treesitter"
paq "lukas-reineke/format.nvim"
paq "bfredl/nvim-miniyank"
paq "junegunn/fzf"
paq "junegunn/fzf.vim"
paq "kyazdani42/nvim-web-devicons"
paq "kyazdani42/nvim-tree.lua"
paq "Glench/Vim-Jinja2-Syntax"
paq "f-person/git-blame.nvim"
paq "b3nj5m1n/kommentary"
paq "neovim/nvim-lspconfig"
paq "kabouzeid/nvim-lspinstall"
paq "dense-analysis/ale"
paq "nathunsmitty/nvim-ale-diagnostic"
paq "hrsh7th/nvim-compe"
paq "SirVer/ultisnips"
paq "nvim-treesitter/playground"

-- paq "christoomey/vim-tmux-navigator"

-- after plugins, run their setup

require "my_pkg_cfg"

cmd "filetype plugin indent on"
