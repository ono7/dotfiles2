local cmd, fn = vim.cmd, vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/paqs/opt/paq-nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  cmd("!git clone https://github.com/savq/paq-nvim.git " .. install_path)
  vim.api.nvim_exec([[autocmd VimEnter * PaqSync]], false)
end

cmd "packadd paq-nvim"

require "paq" {
  {"savq/paq-nvim", opt = true},
  "tpope/vim-eunuch",
  "tpope/vim-surround",
  "tpope/vim-repeat",
  "junegunn/fzf",
  "junegunn/fzf.vim",
  "norcalli/snippets.nvim",
  "dense-analysis/ale",
  "Glench/Vim-Jinja2-Syntax",
  "b3nj5m1n/kommentary",
  "bfredl/nvim-miniyank",
  "kyazdani42/nvim-tree.lua",
  "kyazdani42/nvim-web-devicons",
  "lukas-reineke/format.nvim",
  "numToStr/Navigator.nvim",
  {"nvim-treesitter/nvim-treesitter", branch = "0.5-compat", run = ":TSUpdate"},
  -- "nvim-treesitter/playground",
  -- "f-person/git-blame.nvim",
  -- "SirVer/ultisnips",
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-compe",
  "kabouzeid/nvim-lspinstall"
}

--- setup packages ---
require "my_pkg_cfg"
