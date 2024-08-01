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

-- right alinged
vim.opt.winbar = "%=%M %-.45f %-m {%{get(b:, 'branch_name', '')}}"

-- vim.opt.winbar = "%=%M %-.45f %-m {%{get(b:, 'gitsigns_status', '')}}"

-- vim.opt.winbar = "%=%M %f %m %-14.(%{luaeval('require(\"nvim-web-devicons\").get_icon(vim.fn.expand(\"%:p\"), vim.fn.expand(\"%:e\"), { default = true })')}) %y {%{get(b:, 'gitsigns_status', '')}} %l:%c"

-- might need this in the future
vim.g.skip_ts_context_commentstring_module = true

vim.g.markdown_fold_style = "nested"

-- reuse same window
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_liststyle = 3

require("config.disabled")
require("config.legacy")
require("config.abbreviations")
require("config.diff-settings")
require("config.vars")
require("config.settings")
require("config.helper-functions")
require("config.lazy-bootstrap")
require("config.lazy-config")
require("config.keymaps")
require("config.cmds")

vim.o.guicursor = "" -- uncomment for beam cursor
vim.o.mouse = "n"

--- vim.cmd("set guicursor+=a:-blinkwait75-blinkoff75-blinkon75")
