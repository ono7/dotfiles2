--- Follow the white rabbit ---

local cmd, g, m = vim.cmd, vim.g, vim.api.nvim_set_keymap
local opt = {noremap = true}
local silent = {noremap = true, silent = true}
local MYHOME = os.getenv("HOME")
local PRJCTAG = os.getenv("PRJCTAG")

g.loaded_matchit = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1
g.loaded_tarPlugin = 1
g.loaded_gzip = 0
g.loaded_zipPlugin = 1
g.loaded_2html_plugin = 1
g.loaded_shada_plugin = 1
g.loaded_spellfile_plugin = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_remote_plugins = 1

if PRJCTAG ~= nil then
  vim.o.tags = PRJCTAG .. [[,tags,vtags]]
else
  vim.o.tags = [[./tags,tags,.tags,vtags,.vtags]]
end

--- map leader ---
m("n", "<Space>", "", {})
g.mapleader = " "

vim.o.path = vim.o.path .. "**"

-- nop
m("n", "<c-z>", "", opt)
m("c", "<c-z>", "", opt)
m("n", "ZZ", "", opt)
m("n", "ZQ", "", opt)

--- hold my beer ---
m("n", "<c-[>", "<cmd>noh<cr>1<c-g>", silent)
m("n", "cw", "ciw", silent)
m("n", "dw", "diw", silent)
m("n", "yw", "yiw", silent)
m("c", "<c-a>", "<Home>", {})
m("c", "<c-h>", "<Left>", {})
m("c", "<c-l>", "<Right>", {})
m("i", "<c-e>", "<c-o>$", silent)
m("i", "<c-a>", "<c-o>^", silent)
m("i", "<m-b>", "<c-o>B", silent)
m("i", "<m-f>", "<c-o>W", silent)
m("n", "gp", "`[v`]", silent)
m("n", "Q", "@q", opt)
m("v", "Q", ":'<,'>norm @q<cr>", silent)
m("n", "<leader>d", ":bd!<cr>1<c-g>", silent)
m("n", "<leader>q", ":qall!<cr>", silent)
m("n", "<leader>w", [[:call v:lua.pre_write()<cr>]], silent)
m("n", "Y", "y$", opt)
m("n", "D", "d$", opt)
m("v", "y", "mxy`x", opt)
m("n", "cp", "yap<S-}>p", opt)
m("n", "U", "<c-r>", opt)

-- disable ale lsp
g.ale_disable_lsp = 1

--- providers settings ---
g.python_host_skip_check = 1
g.python2_host_skip_check = 1
g.python3_host_skip_check = 1
g.loaded_python_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.python3_host_prog = MYHOME .. "/.virtualenvs/prod3/bin/python3"

function _G.pre_write()
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

cmd "syntax enable"
cmd "set synmaxcol=512"
cmd "syntax sync minlines=256"
cmd "syntax sync maxlines=300"
cmd "syntax on"

require "onedark".setup {}

cmd "hi!  snipLeadingSpaces  ctermbg=0  guibg=none  guifg=none"

require "my_maps"
require "my_vars"
require "my_cmds"
require "my_settings"
require "my_pkg"
require "my_lsp_compe"

cmd [[command! Mktags !ctags -R . ]]

--[[

  -- TODO (jlima) : 07-02-2021 | https://youtu.be/XA2WjJbmmoM

  NOTES:

  :ls -> list buffer
  :b ini -> opens init.vim, just need to type part of the buffer name
  :find *dark.lua -> onedark.lua (recursively searches for files, use regex for fuzzy find)
  c^ switch to last file edited
  gi -> last insert text position
  vimgrep /regex/j **/*.lua -> search in all lua files, j = dont open (quickfix)
  prefix any fzf with single quote for exact match!!  Rg> '<c-n>
  > finds only lines containing <c-n>

  negative lookahead

  \v---(.* ---)@!

  finds all occurances of --- that do not end with ---

  positive look ahead

  \v---(.*bit ---)@=

  finds all occurances of --- that end with "bit ----"

--]]
