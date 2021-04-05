-- auto install paq if not exists

local cmd, fn = vim.cmd, vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/paqs/opt/paq-nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  -- download and install if missing
  cmd("!git clone https://github.com/savq/paq-nvim.git " .. install_path)
  vim.api.nvim_exec([[autocmd VimEnter * PaqInstall]], false)
end

cmd "packadd paq-nvim"
local paq = require "paq-nvim".paq

-- let paq-nvim manage it self
paq {"savq/paq-nvim", opt = true}

-- vimscript
paq {"vimwiki/vimwiki", opt = true}
paq "tpope/vim-eunuch"
paq "tpope/vim-markdown"
paq "tpope/vim-surround"
paq "tpope/vim-repeat"
paq "jiangmiao/auto-pairs"
paq "junegunn/fzf"
paq "junegunn/fzf.vim"
paq "SirVer/ultisnips"
paq "dense-analysis/ale"
paq "Glench/Vim-Jinja2-Syntax"

-- native lua
paq "numToStr/Navigator.nvim"
paq "nvim-treesitter/nvim-treesitter"
paq "lukas-reineke/format.nvim"
paq "bfredl/nvim-miniyank"
paq "kyazdani42/nvim-web-devicons"
paq "kyazdani42/nvim-tree.lua"
paq "f-person/git-blame.nvim"
paq "b3nj5m1n/kommentary"
paq "neovim/nvim-lspconfig"
paq "kabouzeid/nvim-lspinstall"
paq "nathunsmitty/nvim-ale-diagnostic"
paq "hrsh7th/nvim-compe"
paq "nvim-treesitter/playground"

-- after plugins, run their setup

require "my_pkg_cfg"

cmd "filetype plugin indent on"

-- install lsp servers in to :echo stdpath("data")
