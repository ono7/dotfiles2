--- Follow the white Rabbit...   🐇
local k = vim.keymap.set
local opt = { noremap = true }
local silent = { noremap = true, silent = true }

-- if nothing else, this are the bare minimum necessities
vim.opt.path:append({ "**" })
vim.opt.shell = "zsh"
vim.opt.clipboard:append("unnamedplus")
vim.opt.wrap = false

--- syntax off to avoid tree-sitter issues
--- see https://thevaluable.dev/tree-sitter-neovim-overview/
vim.opt.syntax = "off"
vim.g.mapleader = " "

k("n", "+", ":e ~/todo.md<cr>", opt)
--- visual select last paste
k("n", "gp", "`[v`]", silent)
--- keep cursor in same position when yanking in visual
k("x", "y", [[ygv<Esc>]], silent)

vim.opt.winbar = "%=%M %-.45f %-m {%{get(b:, 'branch_name', '')}}"

-- might need this in the future
vim.g.skip_ts_context_commentstring_module = true

vim.g.markdown_fold_style = "nested"

-- reuse same window
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_liststyle = 3

require("my.disabled")
require("my.legacy")
require("my.abbreviations")
require("my.diff-settings")
require("my.vars")
require("my.settings")
require("my.helper-functions")
require("my.lazy-bootstrap")
require("my.lazy-config")
require("my.keymaps")
require("my.cmds")


vim.o.guicursor = "" -- uncomment for beam cursor
vim.o.mouse = "n"

--- vim.cmd("set guicursor+=a:-blinkwait75-blinkoff75-blinkon75")
