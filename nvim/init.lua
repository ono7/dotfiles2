-- Follow the white rabbit...

-- TODO: 03-17-2021 | look at LSPkind for lua

-- c-i, c-o switch between previously open files
-- c^ switch to last file edited
-- move with /
-- vimgrep /regex/j **/*.lua -> search in all lua files, j = dont open (quickfix)

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
m("n", "<leader>w", [[:call v:lua.pre_write()<cr>]], silent)
m("n", "<tab>", ":bnext<cr>", silent)
m("n", "<s-tab>", ":bprevious<cr>", silent)
m("n", "Y", "y$", options)
m("v", "y", "mxy`x", options)
m("n", "<c-z>", "", options) -- nop
m("c", "<c-z>", "", options) -- nop
m("n", "cp", "yap<S-}>p", options)
m("n", "U", "<c-r>", options)
vim.o.path = vim.o.path .. "**"

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
function _G.legacy()
  -- get vim legacy config :lua legacy()
  vim.api.nvim_paste(require("extra_vars").legacy_cfg, "", -1)
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

function _G.pre_write()
  local cpos = vim.api.nvim_win_get_cursor(0)
  vim.bo.expandtab = true
  cmd([[%retab!]])
  cmd([[%s/\s\+$//e]])
  if g.loaded_format == 1 then
    cmd([[FormatWrite!]])
  end
  local val, err = vim.api.nvim_win_set_cursor(0, cpos)
  cmd([[update]])
end

require "my_cmds"
require "my_vars"
require "my_maps"
require "my_settings"
require "my_pkg"

cmd "colorscheme onehalfdark"
cmd "syntax enable"
cmd "set synmaxcol=512"
cmd "syntax sync minlines=256"
cmd "syntax sync maxlines=300"
cmd "syntax on"

cmd [[au TextYankPost * silent! lua vim.highlight.on_yank{higroup="Cursor", timeout = 100 }]]
