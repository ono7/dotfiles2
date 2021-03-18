-- Follow the white rabbit...

-- TODO: 03-17-2021 | look at LSPkind for lua
-- TODO: 03-17-2021 | use wWbB  and oO to insert code ..more....

local cmd, g, m = vim.cmd, vim.g, vim.api.nvim_set_keymap

-- binding opts
options = {
  noremap = true
}
silent = {
  noremap = true,
  silent = true
}

-- leader
m("n", "<Space>", "", {})

g.mapleader = " "

-- secret sauce
m("n", ";", ":", options)
m("v", ";", ":", options)
m("i", "jk", "<esc><cmd>noh<cr><c-g>", silent)
m("x", "<c-j>", "<esc>", {})
m("n", "gj", "j", options)
m("n", "gk", "k", options)
m("n", "Q", "@q", options)
m("n", "<leader>d", ":bd!<cr>", options)
m("n", "<leader>q", ":qall!<cr>", options)
m("n", "<leader>w", ":update<cr>", silent)
m("n", "<tab>", ":bnext<cr>", silent)
m("n", "<s-tab>", ":bprevious<cr>", silent)
m("n", "Y", "y$", options)
m("v", "y", "mxy`x", options)
m("n", "<c-z>", "<nop>", options)
m("c", "<c-z>", "<nop>", options)
m("n", "cp", "yap<S-}>p", options)

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

-- providers
g.python_host_skip_check = 1
g.python2_host_skip_check = 1
g.python3_host_skip_check = 1
g.loaded_python_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.python3_host_prog = os.getenv("HOME") .. "/.virtualenvs/prod3/bin/python3"

-- highlight yanked text
cmd [[au TextYankPost * silent! lua vim.highlight.on_yank{higroup="Cursor", timeout = 100 }]]

-- hold my beer
require "pkg"
require "maps"
require "vars"
require "settings"
require "autocmds"

-- color and syntax related
cmd "colorscheme onehalfdark"
cmd "syntax enable"
cmd "syntax sync minlines=256"
cmd "syntax sync maxlines=300"
cmd "syntax on"
