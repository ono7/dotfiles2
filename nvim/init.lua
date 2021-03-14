-- Follow the white rabbit...

local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local indent = 2

require("settings")
require("keymaps")
require("utils")

-- cmd "colorscheme base16-onedark"
cmd "syntax enable"
-- set synmaxcol=0
cmd "syntax sync minlines=256"
cmd "syntax sync maxlines=300"
cmd "syntax on"

g.mapleader = " "
g.vimsyn_embed = "l"

-- Auto install packer.nvim if not exists
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end
