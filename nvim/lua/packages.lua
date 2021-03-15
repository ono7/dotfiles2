-- auto install paq if not exists

local cmd,
  fn,
  g =
  vim.cmd,
  vim.fn,
  vim.g

local install_path =
  fn.stdpath(
  "data"
) ..
  "/site/pack/paqs/opt/paq-nvim"
if
  fn.empty(
    fn.glob(
      install_path
    )
  ) >
    0
 then
  cmd(
    "!git clone https://github.com/savq/paq-nvim.git " ..
      install_path
  )
end

-- setup paq
cmd "packadd paq-nvim"
local paq =
  require "paq-nvim".paq

-- plugins
paq {
  "savq/paq-nvim",
  opt = true
}
paq {
  "neoclide/coc.nvim",
  branch = "release"
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
paq "bfredl/nvim-miniyank"
paq "junegunn/fzf"
paq "junegunn/fzf.vim"
-- paq "Glench/Vim-Jinja2-Syntax"

-- after plugins
require "package_setup"

cmd "filetype plugin indent on"

-- Plug 'scrooloose/nerdtree',{ 'on': ['NERDTreeToggle', 'NERDTree', 'NERDTreeFind', 'NERDTreeClose'] }
-- Plug 'vimwiki/vimwiki'
