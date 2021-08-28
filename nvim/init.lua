-- Follow the white rabbit...

local cmd, g, m = vim.cmd, vim.g, vim.api.nvim_set_keymap
local xpr = {noremap = true, expr = true}
local opt = {noremap = true}
local silent = {noremap = true, silent = true}
local MYHOME = os.getenv("HOME")
local PRJCTAG = os.getenv("PRJCTAG")

vim.o.shadafile = "/tmp/.shada"
vim.o.shada = "'30,<50,s10,:30,/30,h,r/tmp"

g.loaded_gzip = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_zipPlugin = 1
g.loaded_2html_plugin = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_matchit = 1
g.loaded_spec = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1
g.loaded_tarPlugin = 1
g.loaded_spellfile_plugin = 1
g.loaded_remote_plugins = 1

--- provider settings ---
g.python_host_skip_check = 1
g.python2_host_skip_check = 1
g.python3_host_skip_check = 1
g.loaded_python_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.python3_host_prog = MYHOME .. "/.virtualenvs/prod3/bin/python3"

--- hold my beer ---

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

-- text operations
m("n", "yw", "yiw", silent)
m("n", "gi", "gi<c-o>zz", silent)
m("n", "gp", "`[v`]", silent) -- vs last past
m("n", "Q", "@q", opt)
m("n", "<leader>d", ":bd!<cr>1<c-g>", silent)
m("v", "<leader>d", "<c-c>:bd!<cr>1<c-g>", silent)
m("n", "<leader>q", ":qall!<cr>", silent)
m("v", "<leader>q", "<c-c>:qall!<cr>", silent)
m("n", "<leader>w", ":call v:lua.remove_whitespace()<cr>", silent)
m("v", "<leader>w", "<c-c>:call v:lua.remove_whitespace()<cr>", silent)
m("n", "<leader>r", [[:call v:lua.format_and_write()<cr>]], silent)
m("v", "<leader>r", [[<c-c>:call v:lua.format_and_write()<cr>]], silent)
m("n", "vw", "viw", opt)
m("n", "vW", "viW", opt)
m("n", "Y", "y$", opt)
m("n", 'y"', 'yi"', opt)
m("n", "y'", "yi'", opt)
m("n", "D", "d$", opt)
m("n", "cp", "yap<S-}>p", opt)
m("n", "U", "<c-r>", opt)

-- correct spelling @word
m("n", "zz", [[zz msz=1<CR><CR>`s]], silent)

m("n", 's"', [[ciw"<c-r><c-p>""]], silent)
m("n", "s'", [[ciw'<c-r><c-p>"']], silent)

m("n", "v", "<C-V>", opt)
m("n", "<C-V>", "v", opt)
m("v", "v", "<C-V>", opt)
m("v", "<C-V>", "v", opt)
m("v", "y", "mxy`x", opt)
m("v", "Q", ":'<,'>norm @q<cr>", silent)

m("c", "<c-a>", "<Home>", opt)
m("c", "<c-h>", "<Left>", opt)
m("c", "<c-l>", "<Right>", opt)

m("i", "<c-e>", "<c-o>$", silent)
m("i", "<c-a>", "<c-o>^", silent)
m("i", "<m-b>", "<c-o>B", silent)
m("i", "<m-f>", "<c-o>E", silent)
m("n", "<c-a>", "^", opt)
m("n", "<c-e>", "g_", opt)
m("v", "<c-e>", "g_", opt)

m("i", "`", "``<left>", opt)
m("i", "(", "()<left>", opt)
m("i", "{", "{}<left>", opt)
m("i", "[", "[]<left>", opt)
m("i", "<c-d>", "<cr><esc>O", opt)
m("i", ")", [[strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"]], xpr)
m("i", "}", [[strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"]], xpr)
m("i", "]", [[strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"]], xpr)
m("i", "'", [[strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"]], xpr)
m("i", '"', [[strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"]], xpr)
-- m("i", "{;<cr>", "{<cr>};<esc>O", opt)

function _G.put(...)
  local objects = {}
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end
  print(table.concat(objects, "\n"))
  return ...
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local myp = {
  ["("] = ")",
  ["["] = "]",
  ["{"] = "}",
  ["<"] = ">",
  ["'"] = "'",
  ['"'] = '"',
  ["`"] = "`"
}

function _G.del_pairs()
  -- compare ')' == ')'
  -- -> delete both pairs <del><c-h> or single backspace if false
  local line = vim.fn.getline(".")
  local prev_col, next_col = vim.fn.col(".") - 1, vim.fn.col(".")
  return myp[line:sub(prev_col, prev_col)] == line:sub(next_col, next_col) and t "<del><c-h>" or t "<bs>"
end

m("i", "<bs>", "v:lua.del_pairs()", xpr)
m("i", "<c-h>", "<bs>", {})

-- vim.api.nvim_exec(
--   [[
-- function! Remove_pair() abort
--   let pair = getline('.')[ col('.')-2 : col('.')-1 ]
--   return stridx('""''''()[]<>{}', pair) % 2 == 0 ? "\<del>\<c-h>" : "\<bs>"
-- endfunction

-- inoremap <expr> <bs> Remove_pair()
-- imap <c-h> <bs>
-- ]],
--   true
-- )

cmd [[ command! Ctags exec 'silent !ctags -R --exclude=.git .' ]]
cmd [[ packadd cfilter ]] -- quicklist filter :cfitler[!] /expression/

g.ale_disable_lsp = 1

function _G.remove_whitespace()
  cmd [[let old = @/]]
  cmd [[keepjumps %retab!]]
  cmd [[keepjumps %s/\s\+$//e]]
  cmd [[let @/ = old]]
  cmd "update"
end

function _G.format_and_write()
  vim.bo.expandtab = true
  do
    _G.remove_whitespace()
  end
  if g.loaded_format == 1 then
    cmd "FormatWrite!"
  end
  cmd "update"
  cmd "noh"
  cmd [[:silent !git add %]]
end

cmd "syntax enable"
cmd "set synmaxcol=512"
cmd "syntax sync minlines=256"
cmd "syntax sync maxlines=300"
cmd "syntax on"

function _G.mySyntax()
  cmd [[syntax match myRed /[.]/]]
  cmd [[syntax match myBold /[,:;]/]]
  cmd [[syntax match myCyan /[=<!>-]/ ]]
  cmd [[syntax match myYellow /[*{}]/ ]]
  cmd [==[syntax match myBlue /[\[\]()]/]==]
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

require "onedark".setup {}
cmd "hi!  snipLeadingSpaces  ctermbg=0  guibg=none  guifg=none"

require "my_maps"
require "my_vars"
require "my_settings"
require "my_pkg"
require "my_snips"
require "my_lsp_compe"
require "my_cmds"

if vim.opt.diff:get() then
  vim.wo.signcolumn = "no"
  vim.wo.foldcolumn = "0"
  vim.wo.numberwidth = 1
  vim.wo.number = true
  vim.o.cmdheight = 1
  -- vim.o.diffopt = "filler,internal,algorithm:patience" -- no context, new algo
  -- vim.o.diffopt = "filler,context:0,internal,algorithm:patience,indent-heuristic"
  vim.o.diffopt = "filler,context:0,internal,algorithm:histogram,indent-heuristic"
  -- set diffopt+=iwhite -- ignore white space during diff
  m("n", "]", "]c", opt)
  m("n", "[", "[c", opt)
end

--[[

  git pull --merge
  <c-h> (delete back) and g; (last edit) or `. (last edit mark) and `` (last jump)
  command of the day < c-h delete back in insert mode
  c-i/o> gi, zi (fold enable toggle), X delete left

  npm install lua-fmt prettier pyright jsonlint -g
  pip install black pylint yamllint

  echo system('base64 -d', @")
  :<c-f> (command search)

  insert mode, <c-r> =   system('date'), or 2+2

    -- Lima

--]]
