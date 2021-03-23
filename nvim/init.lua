-- Follow the white rabbit...

-- TODO: 03-17-2021 | look at LSPkind for lua
-- TODO: 03-17-2021 | use wWbB  and oO to insert code ..more....

local cmd, g, m = vim.cmd, vim.g, vim.api.nvim_set_keymap

local options = {
  noremap = true
}

local silent = {
  noremap = true,
  silent = true
}

-- map leader
m("n", "<Space>", "", {})
g.mapleader = " "

-- secret sauce
m("n", ";", ":", options)
m("v", ";", ":", options)
m("n", ":", ";", options)
m("v", ":", ";", options)
m("n", "ma", "mA", {})
m("n", "mb", "mB", {})
m("n", "mc", "mC", {})
m("n", "mm", "mM", {})
m("n", "'a", "'A", {})
m("n", "'b", "'B", {})
m("n", "'c", "'C", {})
m("n", "'m", "'M", {})
m("i", "jk", "<c-c>`^<cmd>noh<cr><c-g>", silent) -- `^ returns cursor to correct position
m("n", "gj", "j", options)
m("n", "gk", "k", options)
m("n", "Q", "@q", options)
m("v", "Q", ":'<,'>norm @q<cr>", options)
m("n", "<leader>d", ":bd!<cr><c-g>", options)
m("n", "<leader>q", ":qall!<cr>", options)
m("n", "<leader>w", ":write<cr>", silent)
m("n", "<tab>", ":bnext<cr>", silent)
m("n", "<s-tab>", ":bprevious<cr>", silent)
m("n", "Y", "y$", options)
m("v", "y", "mxy`x", options)
m("n", "<c-z>", "", options) -- nop
m("c", "<c-z>", "", options) -- nop
m("n", "cp", "yap<S-}>p", options)
m("n", "U", "<c-r>", options)

function _G.pre_write()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.bo.expandtab = true
  cmd([[%retab!]])
  cmd([[%s/\s\+$//e]])
  vim.api.nvim_win_set_cursor(0, pos)
end

function _G.better_insert()
  local line = vim.api.nvim_get_current_line()
  if #line == 0 then
    return '"_ddO'
  else
    return "i"
  end
end

m("n", "i", "v:lua.better_insert()", {expr = true, noremap = true})

-- disable ale before plugins are loaded
g.ale_disable_lsp = 1

-- nvim providers
g.python_host_skip_check = 1
g.python2_host_skip_check = 1
g.python3_host_skip_check = 1
g.loaded_python_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.python3_host_prog = os.getenv("HOME") .. "/.virtualenvs/prod3/bin/python3"

-- hold my beer
require "my_pkg"
require "my_vars"
require "my_settings"
require "my_cmds"
require "my_maps"

cmd "colorscheme onehalfdark"
cmd "syntax enable"
cmd "syntax sync minlines=256"
cmd "syntax sync maxlines=300"
cmd "syntax on"

-- highlight yanked text
cmd [[au TextYankPost * silent! lua vim.highlight.on_yank{higroup="Cursor", timeout = 100 }]]

-- get vim legacy config :lua legacy()
function _G.legacy()
  vim.api.nvim_paste(require("extra_vars").legacy_cfg, "", -1)
end
