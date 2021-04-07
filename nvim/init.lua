-- Follow the white rabbit...

local cmd, g, m = vim.cmd, vim.g, vim.api.nvim_set_keymap

local opt = {noremap = true}

local silent = {noremap = true, silent = true}

if vim.fn.exists("+termguicolors") then
  cmd [[
    let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
    let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
  ]]
end

-- map leader
m("n", "<Space>", "", {})
g.mapleader = " "

-- hold my beer
m("n", "<cr>", "<cmd>noh<cr><c-g>", silent)
m("n", "cw", "ciw", silent)
m("n", "dw", "diw", silent)
m("n", "yw", "yiw", silent)
m("i", "<c-e>", "<c-o>$", silent)
m("i", "<c-a>", "<c-o>^", silent)
m("i", "<m-b>", "<c-o>B", silent)
m("i", "<m-f>", "<c-o>W", silent)
m("n", "gp", "`[v`]", silent)
m("n", "j", "gj", opt)
m("n", "k", "gk", opt)
m("n", "Q", "@q", opt)
m("v", "Q", ":'<,'>norm @q<cr>", silent)
m("n", "<leader>d", ":bd!<cr><c-g>", silent)
m("n", "<leader>q", ":qall!<cr>", silent)
m("n", "<leader>w", [[:call v:lua.pre_write()<cr>]], silent)
m("n", "<tab>", ":bnext<cr>", silent)
m("n", "<s-tab>", ":bprevious<cr>", silent)
m("n", "<c-[>", "<cmd>noh<cr><c-g>", silent)
m("n", "ma", "mA", {})
m("n", "mb", "mB", {})
m("n", "mc", "mC", {})
m("n", "mm", "mM", {})
m("n", "'a", "'A", {})
m("n", "'b", "'B", {})
m("n", "'c", "'C", {})
m("n", "'m", "'M", {})
m("n", "Y", "y$", opt)
m("v", "y", "mxy`x", opt)
m("n", "<c-z>", "", opt)
m("c", "<c-z>", "", opt) -- "" = nop
m("n", "cp", "yap<S-}>p", opt)
m("n", "U", "<c-r>", opt)

vim.o.path = vim.o.path .. "**"

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

function _G.pre_write()
  local cpos = vim.api.nvim_win_get_cursor(0)
  vim.bo.expandtab = true
  do
    cmd [[let old = @/]]
    cmd "%retab!"
    cmd [[%s/\s\+$//e]]
    cmd [[let @/ = old]]
  end
  if g.loaded_format == 1 then
    cmd "FormatWrite!"
  end
  vim.api.nvim_win_set_cursor(0, cpos)
  cmd "update"
  cmd "noh"
end

function _G.legacy()
  -- :lua legacy()
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

require "onedark".setup {}

cmd "hi! snipLeadingSpaces ctermbg=0 guibg=none guifg=none"

-- :LspInstall lua, tssserver, python, bash, yaml

-- insert c-o (undo), c-[ (exit insert)
-- c^ switch to last file edited
-- gi -> last insert text position
-- vimgrep /regex/j **/*.lua -> search in all lua files, j = dont open (quickfix)
