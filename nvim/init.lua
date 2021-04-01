-- Follow the white rabbit...

-- :LspInstall lua, tssserver, pyright, bash, yaml
-- TODO: 03-17-2021 | look at LSPkind for lua

-- c-i, c-o switch between previously open files
-- c^ switch to last file edited
-- move with /
-- vimgrep /regex/j **/*.lua -> search in all lua files, j = dont open (quickfix)

local cmd, g, m = vim.cmd, vim.g, vim.api.nvim_set_keymap

if vim.fn.exists("+termguicolors") then
  cmd [[
    let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
    let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
  ]]
end

local opt = {
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

m("n", "<cr>", "<cmd>noh<cr><cr>", silent)
m("i", "<c-l>", "<esc>A", silent)
m("n", ";", ":", opt)
m("v", ";", ":", opt)
m("n", ":", ";", opt)
m("v", ":", ";", opt)
m("n", "ma", "mA", {})
m("n", "mb", "mB", {})
m("n", "mc", "mC", {})
m("n", "mm", "mM", {})
m("n", "'a", "'A", {})
m("n", "'b", "'B", {})
m("n", "'c", "'C", {})
m("n", "'m", "'M", {})
m("i", "jk", "<c-c>`^<cmd>noh<cr><c-g>", silent) -- `^ returns cursor to correct position
m("n", "gj", "j", opt)
m("n", "gk", "k", opt)
m("n", "Q", "@q", opt)
m("v", "Q", ":'<,'>norm @q<cr>", silent)
m("n", "<leader>d", ":bd!<cr><c-g>", silent)
m("n", "<leader>q", ":qall!<cr>", silent)
m("n", "<leader>w", [[:call v:lua.pre_write()<cr>]], silent)
m("n", "<tab>", ":bnext<cr>", silent)
m("n", "<s-tab>", ":bprevious<cr>", silent)
m("n", "Y", "y$", opt)
m("v", "y", "mxy`x", opt)
m("n", "<c-z>", "", opt)
m("c", "<c-z>", "", opt) -- nop
m("n", "cp", "yap<S-}>p", opt)
m("n", "U", "<c-r>", opt)

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
  cmd [[%retab!]]
  cmd [[%s/\s\+$//e]]
  if g.loaded_format == 1 then
    cmd [[FormatWrite!]]
  end
  local _, _ = vim.api.nvim_win_set_cursor(0, cpos)
  cmd [[update]]
end

function _G.legacy()
  -- get vim legacy config :lua legacy()
  vim.api.nvim_paste(require("extra_vars").legacy_cfg, "", -1)
end

function _G.perflog()
  cmd [[profile start ~/profile.log]]
  cmd [[profile func *]]
  cmd [[profile file *]]
end

require "my_maps"
require "my_vars"
require "my_cmds"
require "my_settings"
require "my_pkg"
require "my_lsp"

cmd "syntax enable"
cmd "set synmaxcol=512"
cmd "syntax sync minlines=256"
cmd "syntax sync maxlines=300"
cmd "syntax on"

-- color things, ty for the lua onedark theme!
require "onedark".setup {}

cmd "hi!  snipLeadingSpaces ctermbg=0    guibg=none     guifg=none"
