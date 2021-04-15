--- locals ---
local cmd, fn = vim.cmd, vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/paqs/opt/paq-nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  -- download and install if missing
  cmd("!git clone https://github.com/savq/paq-nvim.git " .. install_path)
  vim.api.nvim_exec([[autocmd VimEnter * PaqInstall]], false)
end

cmd "packadd paq-nvim"
local paq = require "paq-nvim".paq

--- my dependencies ---
paq {"savq/paq-nvim", opt = true}

paq "vimwiki/vimwiki"
paq "tpope/vim-eunuch"
paq "tpope/vim-markdown"
paq "tpope/vim-surround"
paq "tpope/vim-repeat"
paq "junegunn/fzf"
paq "junegunn/fzf.vim"
paq "SirVer/ultisnips"
paq "dense-analysis/ale"
paq "Glench/Vim-Jinja2-Syntax"
paq "b3nj5m1n/kommentary"
paq "bfredl/nvim-miniyank"
paq "f-person/git-blame.nvim"
paq "kyazdani42/nvim-tree.lua"
paq "kyazdani42/nvim-web-devicons"
paq "lukas-reineke/format.nvim"
paq "numToStr/Navigator.nvim"
paq {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
paq "nvim-treesitter/playground"
paq "windwp/nvim-autopairs"

--- completion ---
paq "nvim-lua/completion-nvim"

--- lsp ---
paq "neovim/nvim-lspconfig"
paq "kabouzeid/nvim-lspinstall"

--- after plugins, run their setup ---
require "my_pkg_cfg"

cmd "filetype plugin indent on"

-- install lsp servers in to :echo stdpath("data")
