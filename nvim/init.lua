--- Follow the white Rabbit...   🐇

--[[
-- pratice ge, jump back do end of word
-- xxd -psd (get hex codes to use with wezterm)

alias vim='vim "+:set path+=** tags=./tags,tags;~ nohls noswapfile nowrap ruler hidden ignorecase incsearch number relativenumber magic nobackup nojoinspaces wildmenu shortmess=coTtaIsO ttyfast mouse=n"'

-- $_ (shell) - access last argument to previous command, !^ - access first argument
-- e.g. mkdir testdir || cd $_ (cd to testdir)

--- brew install universal-ctags

-- :so (source this file)
-- bro filt /this/ old
-- s/\%Vaaa/bbb/g -- \%V replace only inside visual selection
-- use ce or cE instead of cw or cW, easier to type
-- USE gi, jump to last insert position
-- use '' to go back to the cursor position before the last jump
-- use csqb  (changes the nearest quotes.. q is aliased to `, ', " in surround.nvim)
-- "0 - holds recent yanked text
-- "1 - holds recent deleted text
-- stty sane // fix bad terminal
-- z + enter, moves buffer to top of screen
-- count number of matches %s/test//gn (gn n=no op), will show the number of matches
-- is/as = inside sentence, around sentence, ap/ip = around paragraph vs inside paragraph

--]]
vim.cmd([[set termguicolors]])

P = function(x)
  print(vim.inspect(x))
  return x
end

vim.g.markdown_fold_style = "nested"

require("my.disabled")

--- hold my beer ---
local cmd, g, m, k = vim.cmd, vim.g, vim.api.nvim_set_keymap, vim.keymap.set
local xpr = { noremap = true, expr = true }
local opt = { noremap = true }
local silent = { noremap = true, silent = true }

local MYHOME = os.getenv("HOME")

vim.o.shada = "'25,<1000,s1000,:500,/100,h,r/tmp,n~/.shada"

local function get_git_root()
  local dot_git_path = vim.fn.finddir(".git", ".;")
  print(vim.fn.fnamemodify(dot_git_path, ":h"))
  return vim.fn.fnamemodify(dot_git_path, ":h")
end

vim.api.nvim_create_user_command("CdGitRoot", function()
  vim.api.nvim_set_current_dir(get_git_root())
end, {})

vim.g.python3_host_prog = MYHOME .. "/.virtualenvs/prod3/bin/python3"

--- map leader ---
k({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.cmd([[nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k' ]])
vim.cmd([[nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j' ]])

g.mapleader = " "

vim.opt.path:append({ "**" })

--- nop ---
k({ "c", "x", "n" }, "<c-z>", "") -- use this for searching repos
k("n", "<c-f>", "")               -- use this for searching files
k("n", "<c-b>", "")               -- this conflicts with tmux...
k("n", "ZZ", "")
k("n", "ZQ", "")
k("n", "M", "")
k("n", "L", "")
k("n", "H", "")
k("n", "s", "")               -- surround
k("x", "s", "")               -- surround

k("n", "gp", "`[v`]", silent) -- vs last paste
k("v", "y", [[ygv<Esc>]], silent)
k({ "n", "x" }, ",q", ":qa!<cr>", silent)
k("n", ",w", ":w<cr>", silent)
k("n", ",r", vim.lsp.buf.format, silent)

k("n", "<leader>cd", ":lcd %:h<CR>")

-- paste over selection without overwriting clipboard
k("v", "p", [["0p]])
k("v", "P", [["0P]])
-- k("v", "y", [["0y]])
k("v", "d", [["0d]])

-- move blocks of text with s-J s-K in visual mode
-- k("v", "J", ":m '>+1<CR>gv=gv")
-- k("v", "k", ":m '<-2<cr>gv=gv")

k({ "n", "v" }, "J", "mzJ`z") -- when using J keep cursor to the right

k({ "n", "x" }, "v", "<c-v>") -- sigh :)
vim.cmd("vunmap v")

--- crazy editing skillz ---
k("n", "D", "d$", opt)
k("n", "cp", "yap<S-}>p", opt)

k("n", "U", "<c-r>", opt)
-- k("v", "y", "ygv<Esc>", opt) -- return to the cursor position after yank in v mode
-- k("i", "<m-bs>", "<c-w>", opt) -- handle this in alacritty with mod key in config

--- show buffers ---
-- k("n", "<leader>l", ":ls<cr>:b ", opt) -- might conflict with dap breakpoint...

--- basic surround without plugins
m("n", 's"', [[ciw"<c-r><c-p>""]], silent)
m("n", "s'", [[ciw'<c-r><c-p>"']], silent)

-- make dot work in visual mode
m("v", ".", ":norm .<cr>", opt)

-- macros
m("v", "Q", ":'<,'>norm @q<cr>", silent)
m("n", "Q", "@q", opt)

--- quickfix nav ---
k("n", "[q", ":cprev<cr>", opt)
k("n", "]q", ":cnext<cr>", opt)

-- ex/command mode bindings
k("c", "<c-a>", "<Home>", opt)
k("c", "<c-h>", "<Left>", opt)
k("c", "<c-l>", "<Right>", opt)
k("c", "<c-b>", "<S-left>", opt)

k("i", "<c-e>", "<c-o>$", silent)
k("i", "<c-a>", "<c-o>^", silent)

k("i", "(", "()<left>", opt)
k("i", "{", "{}<left>", opt)
k("i", "[", "[]<left>", opt)

local pair_map = {
  ["("] = ")",
  ["["] = "]",
  ["{"] = "}",
  ["<"] = ">",
  ["'"] = "'",
  ['"'] = '"',
  ["`"] = "`",
}

local function prevAndNextChar()
  -- return prevChar, nextChar in relation to current cursor position
  return vim.api.nvim_get_current_line():sub(vim.fn.col('.') - 1, vim.fn.col('.') - 1),
      vim.api.nvim_get_current_line():sub(vim.fn.col('.'), vim.fn.col('.'))
end

local rightBrackets = '[})%]>]'
local quotesAndBrackets = '[\'"`})%]>]'
local sm = string.match

local function testQuotes(prevChar, nextChar)
  if sm(nextChar, '%S') or sm(prevChar, '[%a%d%p]') then
    return true
  end
  return false
end

-- handles ""
k('i', '"', function()
  local p, n = prevAndNextChar()
  if n == '"' then
    return '<Right>'
  elseif sm(p, '[%a]') then
    return '"'
  elseif sm(n, rightBrackets) then
    return '""<Left>'
  elseif testQuotes(p, n) then
    return '"'
  else
    return '""<Left>'
  end
end
, { expr = true })

-- handles ``
k('i', '`', function()
  local p, n = prevAndNextChar()
  if n == '`' then
    return '<Right>'
  elseif sm(n, rightBrackets) then
    return '``<Left>'
  elseif testQuotes(p, n) then
    return '`'
  else
    return '``<Left>'
  end
end
, { expr = true })


-- handles ''
k('i', "'", function()
  local p, n = prevAndNextChar()
  if n == "'" then
    return '<Right>'
  elseif sm(n, rightBrackets) then
    return "''<Left>"
  elseif testQuotes(p, n) then
    return "'"
  else
    return "''<Left>"
  end
end
, { expr = true })


local function testBrackets(prevChar, nextChar)
  if not pair_map[nextChar] then
    return true
  elseif sm(prevChar, '[%S]') and sm(prevChar, rightBrackets) or sm(prevChar, '[%S]') and sm(nextChar, quotesAndBrackets) then
    return true
  end
  return false
end

-- handle []
k('i', '[', function()
  local p, n = prevAndNextChar()
  if n == '[' then
    return '<Right>'
  elseif testBrackets(p, n) then
    return '[]<Left>'
  elseif sm(n, '%S') then
    return '['
  else
    return '[]<Left>'
  end
end
, { expr = true })

k('i', ']', function()
  local _, n = prevAndNextChar()
  if n == ']' then
    return '<Right>'
  else
    return ']'
  end
end
, { expr = true })

-- handle {}
k('i', '{', function()
  local p, n = prevAndNextChar()
  if n == '{' then
    return '<Right>'
  elseif testBrackets(p, n) then
    return '{}<Left>'
  elseif sm(n, '%S') then
    return '{'
  else
    return '{}<Left>'
  end
end
, { expr = true })

k('i', '}', function()
  local _, n = prevAndNextChar()
  if n == '}' then
    return '<Right>'
  else
    return '}'
  end
end
, { expr = true })

-- todo fix this:  ()"trstr"
-- if there is a space before, we should return 1 bracket not two

-- handle ()
k('i', '(', function()
  local p, n = prevAndNextChar()
  if n == '(' then
    return '<Right>'
  elseif testBrackets(p, n) then
    return '()<Left>'
  elseif sm(n, '%S') then
    return '('
  else
    return '()<Left>'
  end
end
, { expr = true })

k('i', ')', function()
  local _, n = prevAndNextChar()
  if n == ')' then
    return '<Right>'
  else
    return ')'
  end
end
, { expr = true })

-- handle < >
-- k('i', '<', function()
--   local p, n = prevAndNextChar()
--   if n == '<' then
--     return '<Right>'
--   elseif testBrackets(p, n) then
--     return '<><Left>'
--   elseif sm(n, '%S') then
--     return '<'
--   else
--     return '<><Left>'
--   end
-- end
-- , { expr = true })

k('i', '>', function()
  local _, n = prevAndNextChar()
  if n == '>' then
    return '<Right>'
  else
    return '>'
  end
end
, { expr = true })

k('i', ' ', function()
  local p, n = prevAndNextChar()
  if sm(n, rightBrackets) then
    return '<space><space><left>'
  else
    return '<space>'
  end
end
, { expr = true })



k("i", "<BS>", function()
  -- compare ')' == ')'
  -- -> delete both pairs <del><c-h> or single backspace if false
  local line = vim.fn.getline(".")
  local prev_col, next_col = vim.fn.col(".") - 1, vim.fn.col(".")
  return pair_map[line:sub(prev_col, prev_col)] == line:sub(next_col, next_col) and "<del><c-h>" or "<bs>"
end, xpr)

local pair_map_2 = {
  ["("] = ")",
  ["["] = "]",
  ["{"] = "}",
}

k("i", "<enter>", function()
  -- use this one when we are autoclosing
  local line = vim.fn.getline(".")
  local prev_col, _ = vim.fn.col(".") - 1, vim.fn.col(".")
  return pair_map_2[line:sub(prev_col, prev_col)] and "<enter><Esc>O" or "<Enter>"
end, { expr = true })

-- k("i", "<enter>", function()
--   -- use this one when we are not autoclosing
--   local line = vim.fn.getline(".")
--   local prev_col, _ = vim.fn.col(".") - 1, vim.fn.col(".")
--   return pair_map_2[line:sub(prev_col, prev_col)]
--       and "<enter>" .. pair_map_2[line:sub(prev_col, prev_col)] .. "<Esc>O"
--       or "<Enter>"
-- end, { expr = true })

--- resize window ---
k("n", "<M-j>", [[:resize -2<cr>]], silent)
k("n", "<M-k>", [[:resize +2<cr>]], silent)
k("n", "<M-l>", [[:vertical resize -2<cr>]], silent)
k("n", "<M-h>", [[:vertical resize +2<cr>]], silent)

--- tmux ---
k("n", "<leader>t", [[:silent !tmux send-keys -t 2 c-p Enter<cr>]], silent)

--- visual selection search ---
k("v", "<enter>", [[y/\V<C-r>=escape(@",'/\')<CR><CR>]], silent)

--- marks/jumps ---
-- k("n", "'", "`", opt)
k("n", "mm", "mM", opt)
k("n", "ma", "mA", opt)
k("n", "mB", "mB", opt)
k("n", "'m", [[`M'\"]], opt)
k("n", "'a", [[`A'\"]], opt)
k("n", "'b", [[`B'\"]], opt)

k("i", "<C-c>", "<Esc>", opt)
k("n", "Y", "y$", opt)

-- keep cursor in the middle when using search
k("n", "n", "nzzzv", opt)
k("n", "N", "Nzzzv", opt)
k("n", "<C-d>", "<C-d>zz", opt)
k("n", "<C-u>", "<C-u>zz", opt)

--- terminal ---
k("t", "<Esc>", [[<c-\><c-n>]], silent)

cmd([[ packadd cfilter ]]) -- quicklist filter :cfitler[!] /expression/

cmd("syntax enable")
cmd("set synmaxcol=512")
cmd("syntax sync minlines=256")
cmd("syntax sync maxlines=300")
cmd("syntax on")

function _G.legacy()
  -- :lua legacy()
  vim.api.nvim_paste(require("my.extra_vars").legacy_cfg, "", -1)
end

function _G.legacy_min()
  -- :lua legacy()
  vim.api.nvim_paste(require("my.extra_vars").legacy_min, "", -1)
end

function _G.perflog()
  cmd([[profile start ~/profile.log]])
  cmd([[profile func *]])
  cmd([[profile file *]])
end

--- :grep magic ---
cmd([[cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep'  : 'grep']])
cmd([[cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent lgrep' : 'lgrep']])

--- miniyank ---
-- m("n", "p", [[<Plug>(miniyank-autoput)]], {})
-- m("n", "P", [[<Plug>(miniyank-autoPut)]], {})

-- leave unnnamed reg alone when changing text
k("n", "c", '"ac')
k("n", "C", '"aC')

k("n", ";", ":")
-- switch between current and prev file
k("n", "<space><space>", "<c-^>")

--- shellcode ---
-- m(
-- 	"x",
-- 	"<space>h",
-- 	[[:s/\v\s+//ge<cr><bar> :s/\v(..)/\\\x\1/ge<cr><bar> :s/\v.*/buffer \+\= b"&"/ge<cr>:noh<cr>]],
-- 	silent
-- )

local packages = {
  "my.vars",
  "my.cmds",
  "my.settings",
  "my.lazy",
  "plugins.lsp.mason", -- mason first, or lsp breaks
  "plugins.treesitter",
  "plugins.telescope",
  "plugins.navigator",
  "plugins.neotree",
  "plugins.surround",
  "plugins.theme_catppuccin", -- 2
  -- "plugins.snippet",
  "plugins.bufferline",
  "plugins.floaterm",
  "plugins.lsp.cmp",
  "plugins.null_ls",
  "plugins.gitsigns",
  -- "plugins.harpoon",
  -- "plugins.core_dap",
  -- "plugins.dap_adapters",
}

for _, mod in ipairs(packages) do
  local ok, err = pcall(require, mod)
  if not ok then
    error("Module -> " .. mod .. " not loaded... ay.." .. err)
  end
end

vim.cmd([[cabbrev q1 q!]])
vim.cmd([[cabbrev qall1 qall!]])

-- vim.cmd([[hi! clear FloatBorder]])

vim.cmd([[
function! Esc()
python3 << EOF_
import vim

# reference from re module, py3.8, removed empty space :)
# adding ' and " for python processing!
# c_map = {i: '\\' + chr(i) for i in b'()[]{}?*+-|^$\\.&~#\t\n\r\v\f\'\"'}
c_map = {i: '\\' + chr(i) for i in b'()[]{}?*+-|^$\\.&~#\n\r\v\f\'\"'}

def escape(pattern):
    if isinstance(pattern, str):
        return pattern.translate(c_map)
    else:
        pattern = str(pattern, 'latin1')
        return pattern.translate(c_map).encode('latin1')

vim.current.line = escape(vim.current.line)

EOF_
endfunction
command! -nargs=? -range Esc call Esc()

function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register Cm call CopyMatches(<q-reg>)
]])

if vim.opt.diff:get() then
  vim.wo.signcolumn = "no"
  vim.wo.foldcolumn = "0"
  vim.wo.numberwidth = 1
  vim.wo.number = true
  vim.o.cmdheight = 2
  vim.o.diffopt = "filler,context:0,internal,algorithm:histogram,indent-heuristic"
  vim.o.laststatus = 3
  m("n", "]", "]c", opt)
  m("n", "[", "[c", opt)
end

-- vim.o.guicursor = "" -- uncomment for beam cursor
vim.cmd("set guicursor+=a:-blinkwait75-blinkoff75-blinkon75")
vim.o.mouse = "n"
vim.cmd([[hi! link FidgetTask Comment]])
vim.cmd([[hi! link FidgetTitle Title]])
