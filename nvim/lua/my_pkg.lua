--- locals ---
local cmd, fn = vim.cmd, vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/paqs/opt/paq-nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  -- download and install if missing
  cmd("!git clone https://github.com/savq/paq-nvim.git " .. install_path)
  vim.api.nvim_exec([[autocmd VimEnter * PaqInstall]], false)
end

cmd "packadd paq-nvim"

--- my dependencies ---
require "paq" {
  {"savq/paq-nvim", opt = true},
  "tpope/vim-eunuch",
  "tpope/vim-markdown",
  "tpope/vim-surround",
  "tpope/vim-repeat",
  "junegunn/fzf",
  "junegunn/fzf.vim",
  "SirVer/ultisnips",
  "dense-analysis/ale",
  "Glench/Vim-Jinja2-Syntax",
  "b3nj5m1n/kommentary",
  "bfredl/nvim-miniyank",
  "f-person/git-blame.nvim",
  "kyazdani42/nvim-tree.lua",
  "kyazdani42/nvim-web-devicons",
  "lukas-reineke/format.nvim",
  "numToStr/Navigator.nvim",
  {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"},
  "nvim-treesitter/playground",
  -- "windwp/nvim-autopairs",
  --- lsp ---;
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-compe",
  "kabouzeid/nvim-lspinstall"
}
--- after plugins; run their setup ---
require "my_pkg_cfg"
