--- Follow the white Rabbit...   🐇

--[[

golang: https://fulltimegodev.teachable.com/courses/1970304

* save as root
    :w !sudo tee %

* convert spaces to tabs (and back)
    to spaces            to tabs
        :set expandtab       :set noexpandtab
        :set tabstop=4       :retab!
        :set shiftwidth=4
        :retab

* move with c-d (down) and c-u (up)
* use Ff Tt to move horizontally
* g, - jump to last change
* zm, fold
* zi, toggle fold
* sliped `brew install slides`

* my vanilla config

alias vim='vim -c "hi! link Search IncSearch" -c "inoremap <C-e> <C-o>$" -c "inoremap <C-a> <C-o>^" -c "nnoremap ,d :bd!<cr>" -c "nnoremap ,q :qall!<cr>" -c "nnoremap ,w :w<cr>" "+:set path+=** tags=./tags,tags;~ nohls noswapfile nowrap ruler hidden ignorecase incsearch magic nobackup nojoinspaces wildmenu shortmess=coTtaIsO list listchars=trail:·,nbsp:· ttyfast ai sw=2 sts=2 mouse=n clipboard+=unnamedplus background=dark gp=git\ grep\ -n"'

alias vl="vim -c \"normal '0\" -c \"bn\" -c \"bd\""

* replace with contents of register :s/abc/\=getreg('*')/g
	*  ge, jump back do end of word
	*  xxd -psd (get hex codes to use with wezterm)

	*  $_ (shell) - access last argument to previous command, !^ - access first argument
	*  e.g. mkdir testdir || cd $_ (cd to testdir)

	* - brew install universal-ctags

	*  :so (source this file)
	*  bro filt /this/ old
	*  s/\%Vaaa/bbb/g -- \%V replace only inside visual selection
	*  use ce or cE instead of cw or cW, easier to type
	*  USE gi, jump to last insert position
	*  use '' to go back to the cursor position before the last jump
	*  use csqb  (changes the nearest quotes.. q is aliased to `, ', " in surround.nvim)
	*  "0 - holds recent yanked text
	*  "1 - holds recent deleted text
	*  stty sane // fix bad terminal
	*  count number of matches %s/test//gn (gn n=no op), will show the number of matches
--]]

vim.cmd([[
  augroup LowerPriorityOnStartup
    autocmd!
    autocmd VimEnter * silent! execute "!sudo renice -n -18 -p " .. vim.loop.os_getppid()
  augroup END
]])

vim.opt.winbar = "%=%M %-.45f %-m %y"

-- might need this in the future
vim.g.skip_ts_context_commentstring_module = true

-- vim.g.t_Co = 8
-- local f = require "ffi"
-- f.cdef "int t_colors"
-- f.C.t_colors = 16

vim.opt.termguicolors = true
vim.opt.syntax = "off"

--- if syntax is on/enabled treesitter has issues
--- other weird things happen, like lsp not starting automatically etc
--- see https://thevaluable.dev/tree-sitter-neovim-overview/

P = function(x)
  print(vim.inspect(x))
  return x
end

vim.g.markdown_fold_style = "nested"

local my_disabled_ok, _ = pcall(require, "my.disabled")

if not my_disabled_ok then
  print("Error in pcall my.disabled -> ~/.dotfiles/nvim/init.lua")
end

--- hold my beer ---
local cmd, g, m, k = vim.cmd, vim.g, vim.api.nvim_set_keymap, vim.keymap.set
local xpr = { noremap = true, expr = true }
local opt = { noremap = true }
local silent = { noremap = true, silent = true }

local MYHOME = os.getenv("HOME")

vim.o.shada = "'25,<1000,s1000,:500,/100,h,n~/.shada"

local function get_git_root()
  local dot_git_path = vim.fn.finddir(".git", ".;")
  print(vim.fn.fnamemodify(dot_git_path, ":h"))
  return vim.fn.fnamemodify(dot_git_path, ":h")
end

local function get_visual_selection()
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  return table.concat(lines, '\n')
end

vim.api.nvim_create_user_command("CdGitRoot", function()
  vim.api.nvim_set_current_dir(get_git_root())
end, {})

vim.g.python3_host_prog = MYHOME .. "/.virtualenvs/prod3/bin/python3"

--- map leader ---
k({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

--- update jump list whenn we hop more than one line ---
-- vim.cmd([[nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k' ]])
-- vim.cmd([[nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j' ]])

-- add movements bigger then 1 line to the jump list, but also navigate through wrapped lines
vim.cmd([[nnoremap <expr> j v:count ? (v:count > 1 ? "m'" . v:count : '') . 'j' : 'gj']])
vim.cmd([[nnoremap <expr> k v:count ? (v:count > 1 ? "m'" . v:count : '') . 'k' : 'gk']])

g.mapleader = " "

vim.opt.path:append({ "**" })

--- nop ---
k("n", "<c-f>", "") -- use this for searching files
--- k("n", "<c-b>", "") -- allow tmux prefix to be used to jump to tmux pane
k("n", "ZZ", "")
k("n", "ZQ", "")

-- k({ "n", "x" }, "<c-e>", "g_")

k({ "n", "x" }, "gh", "^")
k({ "n", "x" }, "gl", "g_")

--- vs last paste
k("n", "gp", "`[v`]", silent)

--- keep cursor in same position when yanking in visual
k("v", "y", [[ygv<Esc>]], silent)

-- k("n", "<leader>w", "<cmd>w<cr>", silent)
k("n", "<leader>w", vim.lsp.buf.format, silent)
k("n", ",w", "<cmd>w<cr>", silent)
k("n", ",q", "<cmd>q!<cr>", silent)
k("n", ",d", "<cmd>bd!<cr>", silent)
k("n", "<leader>q", "<cmd>qall<cr>", silent)

--- surround
-- k("n", [[s"]], [[ciw"<c-r><c-p>""]])
-- k("n", [[s']], [[ciw'<c-r><c-p>"']])

-- k("n", [[ci"]], [[/"<CR>ci"]], silent)
-- k("n", [[ci']], [[/'<CR>ci']], silent)
-- k("x", [[vi"]], [[/"<CR>vi"]], silent)
-- k("x", [[vi']], [[/'<CR>vi']], silent)

--- navigate between splits ---
k("n", "<c-k>", "<C-W>k")
k("n", "<c-j>", "<C-W>j")
k("n", "<c-h>", "<C-W>h")
k("n", "<c-l>", "<C-W>l")

-- k("n", ";", ":")
-- k("n", ":", ";")

k("n", "<tab>", ":bnext<CR>", silent)
k("n", "<s-tab>", ":bprevious<CR>", silent)

--- make dot work in visual mode
m("v", ".", ":norm .<cr>", opt)

--- macros
-- m("v", "Q", ":'<,'>norm @q<cr>", silent)
k("n", "Q", "@qj", opt)
k("x", "Q", ":norm @q<CR>", opt)

--- copy block
k("n", "cp", "yap<S-}>p", opt)

--- ex/command mode bindings
k("c", "<c-a>", "<Home>", opt)
k("c", "<c-h>", "<Left>", opt)
k("c", "<c-l>", "<Right>", opt)
k("c", "<c-b>", "<S-left>", opt)

k("i", "<c-e>", "<c-o>$", silent)
k("i", "<c-a>", "<c-o>^", silent)
k("n", "g(", [[?\v\w+.{-}\(\zs<cr>]])
k("n", "g)", [[/\v\w+.{-}\(\zs<cr>]])
k("n", "g{", "?{<cr>")
k("n", "g}", "/}<cr>")
k("n", "g[", [[?\v\w+\[\zs<cr>]])
k("n", "g]", [[/\v\w+\[\zs<cr>]])

local openBrackets = {
  ["("] = true,
  ["["] = true,
  ["{"] = true,
}

local rightBracketsAndQuotes = {
  [")"] = true,
  ["]"] = true,
  ["}"] = true,
  ['"'] = true,
  ["'"] = true,
  ['`'] = true,
  ['\\'] = true,
}

local isQuotes = {
  ['"'] = true,
  ["'"] = true,
  ['`'] = true,
}

local pair_map = {
  ["("] = ")",
  ["["] = "]",
  ["{"] = "}",
  ["<"] = ">",
  ["'"] = "'",
  ['"'] = '"',
  ["`"] = "`",
}

local r_pair_map = {
  [")"] = "(",
  ["]"] = "[",
  ["}"] = "{",
  [">"] = "<",
  ["'"] = "'",
  ['"'] = '"',
  ["`"] = "`",
}

local all_pair_map = {}
local isAlphaNum = {}

for _, v in ipairs(pair_map) do
  table.insert(all_pair_map, v)
end

for _, v in ipairs(r_pair_map) do
  table.insert(all_pair_map, v)
end

for ascii = 97, 122 do -- ASCII values for 'a' to 'z'
  local lowercaseKey = string.char(ascii)
  isAlphaNum[lowercaseKey] = true
  isAlphaNum[string.upper(lowercaseKey)] = true
end

for digit = 48, 57 do -- ASCII values for '0' to '9'
  isAlphaNum[string.char(digit)] = true
end

--- handles ""
k('i', '"', function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col('.')
  local p = line:sub(col - 1, col - 1)
  local n = line:sub(col, col)
  if n == '"' then
    return '<Right>'
  elseif rightBracketsAndQuotes[p] or isAlphaNum[n] then
    return '"'
  elseif openBrackets[n] or isAlphaNum[p] then
    return '"'
  end
  return '""<Left>'
end
, { expr = true })

--- handles ``
k('i', '`', function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col('.')
  local p = line:sub(col - 1, col - 1)
  local n = line:sub(col, col)
  if n == '`' then
    return '<Right>'
  elseif rightBracketsAndQuotes[p] then
    return "`"
  elseif openBrackets[n] then
    return "`"
  end
  return '``<Left>'
end
, { expr = true })

---  handles ''
k('i', "'", function()
  if vim.bo[0].buftype == 'prompt' then
    return "'"
  end
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col('.')
  local p = line:sub(col - 1, col - 1)
  local n = line:sub(col, col)
  if n == "'" then
    return '<Right>'
  elseif rightBracketsAndQuotes[p] or isAlphaNum[n] then
    return "'"
  elseif openBrackets[n] or isAlphaNum[p] then
    return "'"
  end
  return "''<Left>"
end
, { expr = true })

--- handle []
k('i', '[', function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col('.')
  local p = line:sub(col - 1, col - 1)
  local n = line:sub(col, col)
  if n == '[' then
    return '<Right>'
  elseif p == '\\' or isAlphaNum[n] or isQuotes[n] then
    return '['
  end
  return '[]<Left>'
end, { expr = true })

k('i', ']', function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col('.')
  local n = line:sub(col, col)
  if n == ']' then
    return '<Right>'
  end
  return ']'
end
, { expr = true })

--- handle {}
k('i', '{', function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col('.')
  local p = line:sub(col - 1, col - 1)
  local n = line:sub(col, col)
  if n == '{' then
    return '<Right>'
  elseif p == '\\' or isAlphaNum[n] then
    return '{'
  end
  return '{}<Left>'
end
, { expr = true })

k('i', '}', function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col('.')
  local n = line:sub(col, col)
  if n == '}' then
    return '<Right>'
  end
  return '}'
end
, { expr = true })

--- handle ()
k('i', '(', function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col('.')
  local p = line:sub(col - 1, col - 1)
  local n = line:sub(col, col)
  if n == '(' then
    return '<Right>'
  elseif p == '\\' or isAlphaNum[n] or isQuotes[n] then
    return '('
  end
  return '()<Left>'
end
, { expr = true })

k('i', ')', function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col('.')
  local n = line:sub(col, col)
  if n == ')' then
    return '<Right>'
  end
  return ')'
end
, { expr = true })

k('i', '>', function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col('.')
  local n = line:sub(col, col)
  if n == '>' then
    return '<Right>'
  end
  return '>'
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
  [">"] = "<",
}

k("i", "<enter>", function()
  -- use this one when we are autoclosing
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col('.')
  local p = line:sub(col - 1, col - 1)
  local pmap = pair_map_2
  if pmap[p] then
    return "<CR><Esc>O"
  else
    return "<CR>"
  end
end, { expr = true })

--- k("i", "<enter>", function()
---   -- use this one when we are not autoclosing
---   local line = vim.fn.getline(".")
---   local prev_col, _ = vim.fn.col(".") - 1, vim.fn.col(".")
---   return pair_map_2[line:sub(prev_col, prev_col)]
---       and "<enter>" .. pair_map_2[line:sub(prev_col, prev_col)] .. "<Esc>O"
---       or "<Enter>"
--- end, { expr = true })

---- FREE/RECLAIMED BINDINGS ---
-- k("n", "<c-s-k>", "<C-W>k")
-- k("n", "<c-s-j>", "<C-W>j")
-- k("n", "<c-s-h>", "<C-W>h")
-- k("n", "<c-s-l>", "<C-W>l")
-- k("n", "<M-j>", [[:resize -2<cr>]], silent)
-- k("n", "<M-j>", [[:resize -2<cr>]], silent)
-- k("n", "<M-k>", [[:resize +2<cr>]], silent)
-- k("n", "<M-k>", [[:resize +2<cr>]], silent)
-- k("n", "<M-l>", [[:vertical resize -2<cr>]], silent)
-- k("n", "<M-l>", [[:vertical resize -2<cr>]], silent)
-- k("n", "<M-h>", [[:vertical resize +2<cr>]], silent)
-- k("n", "<M-h>", [[:vertical resize +2<cr>]], silent)
-- k("n", "M", "")
-- k("n", "M", "")
-- k("n", "L", "")
-- k("n", "L", "")
-- k("n", "H", "")
-- k("n", "H", "")

--- delete all but the current buffer
k("n", "'d", [[:%bd |e# |bd#<cr>|'"]], silent)

--- -- Lua function to send text to Tmux
--- _G.send_to_tmux = function(text)
---     vim.fn.system('tmux load-buffer -w -', text)
---     print('n |  ')
--- end

-- converts bytes to a string, useful for debugging in delve
_G.BytesToString = function()
  local selected_text = vim.fn.getline("'<,'>")
  -- Remove any whitespace or non-hex characters
  selected_text = selected_text:gsub('[^0-9A-Fa-f]', '')
  -- Check if the selected text is empty
  if selected_text == '' then
    vim.api.nvim_out_write("No valid bytes selected.\n")
  else
    -- Convert hex to string
    local string_result = ''
    local i = 1
    while i <= #selected_text do
      local hex_byte = string.sub(selected_text, i, i + 1)
      string_result = string_result .. string.char(tonumber(hex_byte, 16))
      i = i + 2
    end
    -- Display the result in the message area
    vim.api.nvim_out_write(string_result .. '\n')
  end
end

--- -- Lua function to send text to Tmux
--- _G.send_to_tmux_visual = function()
---     local text = get_visual_selection()
---     if text then
---         vim.fn.system('tmux load-buffer -w -', text)
---         print('v |  ')
---     end
--- end

--- -- Map the key binding for a range of text or selected text
--- k('v', '<leader>y', [[:lua send_to_tmux_visual()<CR>]], { noremap = true, silent = true })

--- -- Map the key binding for the current line (no selection)
--- k('n', '<leader>y', [[:lua send_to_tmux(vim.fn.getline('.'))<CR>]], { noremap = true, silent = true })

--- tmux ---
- k("n", "<leader>t", [[:silent !tmux send-keys -t 2 c-p Enter<cr>]], silent)

--- visual selection search ---
k("v", "<enter>", [[y/\V<C-r>=escape(@",'/\')<CR><CR>]], silent)

--- go struct tags ---
-- k("n", "gtj", [[:GoTagAdd json<cr>]])
-- k("n", "gty", [[:GoTagAdd yaml<cr>]])

-- open notes for today
-- k("n", "<leader>gt", ":e ~/notes/today.md<cr>", opt)

--- marks/jumps ---
--- k("n", "'", "`", opt)
k("n", "mm", "mM", opt)
k("n", "ma", "mA", opt)
k("n", "mB", "mB", opt)
k("n", "'m", [[`M'\"]], opt)
k("n", "'a", [[`A'\"]], opt)
k("n", "'b", [[`B'\"]], opt)

k("i", "<C-c>", "<Esc>", opt)
k("n", "Y", "y$", opt)

k("n", "U", "<c-r>", opt)

--- keep cursor in the middle when using search
k("n", "n", "nzzzv", opt)
k("n", "N", "Nzzzv", opt)
k("n", "<C-d>", "<C-d>zz", opt)
k("n", "<C-u>", "<C-u>zz", opt)

--- paste over selection without overwriting clipboard
k("x", "p", "pgvy")

--- when using J keep cursor to the right
k({ "n", "v" }, "J", "mzJ`z")

--- terminal ---
k("t", "<Esc>", [[<c-\><c-n>]], silent)

--- leave unnnamed reg alone when changing text
k("n", "c", '"ac')
k("n", "C", '"aC')

--- visual block by default
k({ "n" }, "v", "<c-v>")
--- vim.cmd("vunmap v")

cmd([[ packadd cfilter ]]) -- quicklist filter :cfitler[!] /expression/
k("n", "]n", "<cmd>cprev<cr>", opt)
k("n", "[n", "<cmd>cnext<cr>", opt)

function _G.legacy()
  -- :lua legacy()
  vim.api.nvim_paste(require("my.extra_vars").legacy_cfg, true, -1)
end

function _G.legacy_min()
  -- :lua legacy()
  vim.api.nvim_paste(require("my.extra_vars").legacy_min, true, -1)
end

function _G.perflog()
  cmd([[profile start ~/profile.log]])
  cmd([[profile func *]])
  cmd([[profile file *]])
end

--- :grep magic ---
-- cmd([[cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep'  : 'grep']])
-- cmd([[cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent lgrep' : 'lgrep']])

--- shellcode ---
--- m(
--- 	"x",
--- 	"<space>h",
--- 	[[:s/\v\s+//ge<cr><bar> :s/\v(..)/\\\x\1/ge<cr><bar> :s/\v.*/buffer \+\= b"&"/ge<cr>:noh<cr>]],
--- 	silent
--- )

local packages = {
  "my.lazy",
  "my.vars",
  "my.settings",
  "plugins.treesitter",
  "plugins.telescope",
  "plugins.neotree",
  "plugins.surround",
  "plugins.lsp.cmp",
  "plugins.lsp.mason",        -- mason first, or lsp breaks
  "plugins.gitsigns",
  "plugins.theme_catppuccin", -- 2
  "plugins.null_ls",
  -- "plugins.bufferline",
  "plugins.colorizer",
  "my.cmds",
  -- "plugins.harpoon",
  "plugins.core_dap",
}

for _, mod in ipairs(packages) do
  local ok, _ = pcall(require, mod)
  if not ok then
    error("in init.lua, Module -> " .. mod .. " not loaded... ay..")
  end
end

vim.cmd([[cabbrev q1 q!]])
vim.cmd([[cabbrev qall1 qall!]])

vim.cmd([[
function! Esc()
python3 << EOF_
import vim

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

vim.o.guicursor = "" -- uncomment for beam cursor
--- vim.cmd("set guicursor+=a:-blinkwait75-blinkoff75-blinkon75")
vim.o.mouse = "n"
--- # vim:ts=4:sw=4:ai:foldmethod=marker:foldlevel=0:

-- vim.api.nvim_set_hl(0, "SignColumn", {})
-- vim.api.nvim_set_hl(0, "Error", {})
-- vim.api.nvim_set_hl(0, "Cursor", {})
-- vim.api.nvim_set_hl(0, "Cursor", { reverse = true })
-- vim.api.nvim_set_hl(0, "MatchParen", { link = "Cursor" })

-- local base16 = require 'my.base16'
-- base16(base16.themes.tube, true)
