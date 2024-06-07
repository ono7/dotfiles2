--- Follow the white Rabbit...   🐇

--[[

Fix github repos missing remote
  git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

golang: https://fulltimegodev.teachable.com/courses/1970304

* save as root
    :w !sudo tee %

* convert spaces to tabs (and back)
    to spaces            to tabs
        :set expandtab       :set noexpandtab
        :set tabstop=4       :retab!
        :set shiftwidth=4
        :retab

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

--- status bar
-- vim.opt.winbar = "%=%M %-.45f %-m %y {%{get(b:, 'branch_name', '')}}"
vim.opt.winbar = "%=%M %-.45f %-m {%{get(b:, 'branch_name', '')}}"

-- might need this in the future
vim.g.skip_ts_context_commentstring_module = true

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

-- reuse same window
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_liststyle = 3

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

vim.o.shada = "'15,<1000,s1000,:500,/100,h,n~/.shada"

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

-- add movements bigger then 1 line to the jump list, but also navigate through wrapped lines
vim.cmd([[nnoremap <expr> j v:count ? (v:count > 1 ? "m'" . v:count : '') . 'j' : 'gj']])
vim.cmd([[nnoremap <expr> k v:count ? (v:count > 1 ? "m'" . v:count : '') . 'k' : 'gk']])

g.mapleader = " "

vim.opt.path:append({ "**" })

--- nop ---
k("n", "<c-f>", "") -- use this for searching files
k("n", "<c-b>", "") -- allow tmux prefix to be used to jump to tmux pane
k("n", "ZZ", "")
k("n", "ZQ", "")

-- k({ "n", "x" }, "<c-e>", "g_")

-- k({ "n", "x" }, [[\]], [[:vertical Git<cr>]], silent)
--
k({ "n", "x" }, "\\", function()
  local fugitive_buf_found = false
  local windows = vim.api.nvim_list_wins()

  -- Check each window to see if it's showing a Fugitive buffer
  for _, win in ipairs(windows) do
    local buf = vim.api.nvim_win_get_buf(win)
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if string.match(buf_name, "^fugitive://") then
      fugitive_buf_found = true
      -- Close the window that has the Fugitive buffer
      vim.api.nvim_win_close(win, false)
      break
    end
  end

  -- If no Fugitive buffer was found, open Fugitive
  if not fugitive_buf_found then
    vim.cmd(":vertical Git")
  end
end, { silent = true })

-- move selection to far left, far right
k("v", "gh", ":left<cr>", silent)
k("v", "gl", ":right<cr>", silent)

--- vs last paste
k("n", "gp", "`[v`]", silent)

--- keep cursor in same position when yanking in visual
k("x", "y", [[ygv<Esc>]], silent)

k("n", "gx", [[:sil !open <cWORD><cr>]], silent)

-- move cursor to left/right
k("n", "L", "g_", silent)
k("n", "H", "^", silent)

k("x", "<<", function()
  vim.cmd("normal! <<")
  vim.cmd("normal! gv")
end, silent)

-- toggle spell on and off
k("n", "<leader>s", function()
  vim.o.spell = not vim.o.spell
  print(vim.opt.spell._value)
end, silent)

local function check_buf(bufnr)
  --- checks if this is a valid buffer that we can save to ---
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  if bufname == '' then
    return false
  end
  return true
end

local function clean_space_save()
  if not check_buf(0) then
    print("save me first!")
    return
  end
  local save_cursor = vim.fn.getcurpos()
  -- Fixes ^M chars from Windows copy-pastes and removes trailing spaces
  vim.cmd([[%s/\v\s*\r+$|\s+$//e]])
  vim.cmd([[:write]])
  vim.fn.setpos('.', save_cursor)
end

vim.api.nvim_create_user_command('CleanAndSave', clean_space_save, {})

k("n", ",w", function()
  if not check_buf(0) then
    print("save me first!")
    return
  end
  vim.cmd([[%s/\v\s*\r+$|\s+$//e]])
  local status, _ = pcall(vim.lsp.buf.format)
  if not status then
    print("no lsp..")
  end
  vim.cmd [[:write]]
end, silent)

k("n", "<leader>w", ":CleanAndSave<cr>", silent)
k("n", ",q", "<cmd>q<cr>", silent)
k("n", ",x", "<cmd>x!<cr>", silent)
k("n", ",d", "<cmd>bd<cr>", silent)
k("n", "<leader>q", "<cmd>q<cr>", silent)

--- navigate between splits ---
k("n", "<c-k>", "<C-W>k")
k("n", "<c-j>", "<C-W>j")
k("n", "<c-h>", "<C-W>h")
k("n", "<c-l>", "<C-W>l")

k("n", "<tab>", ":bnext<CR>", silent)
k("n", "<s-tab>", ":bprevious<CR>", silent)

--- make dot work in visual mode
m("v", ".", ":norm .<cr>", opt)

--- macros
-- m("v", "Q", ":'<,'>norm @q<cr>", silent)
k("n", "Q", "@qj", opt)
k("x", "Q", ":norm @q<CR>", opt)


local function hlsToggle()
  if vim.o.hlsearch then
    vim.o.hlsearch = false
  else
    vim.o.hlsearch = true
  end
end

k("n", "<leader>h", hlsToggle, silent)

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

--- used by backspace function, to remove pairs
local pair_map = {
  ["("] = ")",
  ["["] = "]",
  ["{"] = "}",
  ["<"] = ">",
  ["'"] = "'",
  ['"'] = '"',
  ["`"] = "`",
}

--- used to insert both () if the next char is (
local r_pair_map = {
  [")"] = true,
  ["]"] = true,
  ["}"] = true,
  [">"] = true,
  [" "] = true,
}

local all_pair_map = {}

for _, v in ipairs(pair_map) do
  table.insert(all_pair_map, v)
end

for _, v in ipairs(r_pair_map) do
  table.insert(all_pair_map, v)
end

local is_quote = function(char)
  return char == "'" or char == '"' or char == '`'
end

local is_bracket = function(char)
  return char == "(" or char == '[' or char == '{' or char == '<'
end


local is_close_bracket = function(char)
  return char == ")" or char == ']' or char == '}' or char == '>'
end




--- for reference using vim script functions
-- local function get_next_and_prev_chars()
--   -- returns p, n
--   local col = vim.fn.col('.')
--   local line = vim.fn.getline('.')
--   return line:sub(col - 1, col - 1), line:sub(col, col)
-- end

-- --- gets only next char
-- local function get_next_char()
--   -- returns next char
--   local line = vim.api.nvim_get_current_line()
--   local col = vim.api.nvim_win_get_cursor(0)[2] + 1 -- Column is 0-indexed, add 1 for Lua string indexing
--   return line:sub(col, col)
-- end

--- returns previous and next characters respectively
-- local function get_next_and_prev_chars()
--   local line = vim.api.nvim_get_current_line()
--   local col = vim.api.nvim_win_get_cursor(0)[2] + 1 -- Column is 0-indexed, add 1 for Lua string indexing
--   return line:sub(col - 1, col - 1), line:sub(col, col)
-- end

-- Returns previous and next characters using Neovim API with range fetching
-- this gets only thes cursor's surrounding characters instead of querying the entire line

local function get_next_and_prev_chars()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0)) -- Cursor position is 0-indexed
  --@param 0 is always the current buffer
  local prev_char = vim.api.nvim_buf_get_text(0, row - 1, col - 1, row - 1, col, {})[1] or ''
  local next_char = vim.api.nvim_buf_get_text(0, row - 1, col, row - 1, col + 1, {})[1] or ''
  return prev_char, next_char
end

local function get_next_char()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local next_char = vim.api.nvim_buf_get_text(0, row - 1, col, row - 1, col + 1, {})[1] or ''
  return next_char
end

-- Function to handle '"'
k('i', '"', function()
  local p, n = get_next_and_prev_chars()
  if n == '"' then
    return '<Right>'
  elseif (p and p:match("%w")) or (n and n:match("%w")) then
    return '"'
  else
    return '""<left>'
  end
end, { expr = true })

-- Function to handle "'" (similar logic)
k('i', "'", function()
  local p, n = get_next_and_prev_chars()
  if n == "'" then
    return '<Right>'
  elseif (p and p:match("%w")) or (n and n:match("%w")) then
    return "'"
  else
    return "''<left>"
  end
end, { expr = true })

-- handle {}
k('i', '[', function()
  local n = get_next_char()
  if r_pair_map[n] then
    return '[]<Left>'
  elseif n ~= '' then
    return '['
  end
  return '[]<Left>'
end, { expr = true })
k('i', ']', function()
  local n = get_next_char()
  if n == ']' then
    return '<Right>'
  end
  return ']'
end
, { expr = true })

-- handle {}
k('i', '{', function()
  local n = get_next_char()
  if r_pair_map[n] then
    return '{}<Left>'
  elseif n ~= '' then
    return '{'
  end
  return '{}<Left>'
end, { expr = true })

k('i', '}', function()
  local n = get_next_char()
  if n == '}' then
    return '<Right>'
  end
  return '}'
end
, { expr = true })

-- handle (
k('i', '(', function()
  local n = get_next_char()
  if r_pair_map[n] then
    return '()<Left>'
  elseif n ~= '' then
    return '('
  end
  return '()<Left>'
end, { expr = true })

k({ 'i' }, ')', function()
  local n = get_next_char()
  if n == ')' then
    return '<Right>'
  end
  return ')'
end
, { expr = true })

k('i', '>', function()
  local n = get_next_char()
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
  ["<"] = ">",
}

k("i", "<enter>", function()
  -- use this one when we are autoclosing
  local prev_col, _ = vim.fn.col('.') - 1, vim.fn.col('.')
  local p = vim.fn.getline('.'):sub(prev_col, prev_col)
  local pmap = pair_map_2
  if pmap[p] then
    return "<CR><Esc>O"
  else
    return "<CR>"
  end
end, { expr = true })

-- k("i", "<enter>", function()
--   -- use this one when we are not autoclosing
--   local line = vim.fn.getline(".")
--   local prev_col, _ = vim.fn.col(".") - 1, vim.fn.col(".")
--   return pair_map_2[line:sub(prev_col, prev_col)]
--       and "<enter>" .. pair_map_2[line:sub(prev_col, prev_col)] .. "<Esc>O"
--       or "<Enter>"
-- end, { expr = true })

--- delete all but the current buffer
k("n", "'d", [[:%bd |e# |bd#<cr>|'"]], silent)

-- Converts selected bytes to a string, useful for debugging
local BytesToString = function(opts)
  local start_row, start_col = unpack(vim.api.nvim_buf_get_mark(0, "<"))
  local end_row, end_col = unpack(vim.api.nvim_buf_get_mark(0, ">"))

  -- Normalize column indices (0-based)
  start_col = start_col + 1
  end_col = end_col + 1

  -- Adjust end column for last line
  if start_row == end_row and start_col == end_col then
    end_col = end_col + 1 -- Include the selected character on the same line
  end

  local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)
  local selected_text = ""

  for i, line in ipairs(lines) do
    local start = (i == 1 and start_col or 1)
    local finish = (i == #lines and end_col or -1) -- -1 means end of line
    selected_text = selected_text .. line:sub(start, finish)
  end

  -- Remove any whitespace or non-hex characters
  selected_text = selected_text:gsub('[^0-9A-Fa-f]', '')

  if selected_text == '' then
    vim.api.nvim_err_writeln("No valid bytes selected.")
    return
  end

  -- Convert hex to string
  local string_result = ''
  for i = 1, #selected_text, 2 do
    local hex_byte = selected_text:sub(i, i + 1)
    string_result = string_result .. string.char(tonumber(hex_byte, 16))
  end

  -- Display the result in a new buffer
  vim.api.nvim_command('new')
  vim.api.nvim_buf_set_lines(0, 0, -1, false, { string_result })
  vim.api.nvim_command('setlocal buftype=nofile bufhidden=wipe noswapfile')
  vim.api.nvim_command('setlocal filetype=text')
  vim.api.nvim_command('setlocal nonumber norelativenumber')
  vim.api.nvim_win_set_cursor(0, { 1, 0 }) -- Move the cursor to the beginning of the buffer
end

vim.api.nvim_create_user_command('BytesToString', BytesToString, { range = true, nargs = 0 })

--- tmux ---
-- TODO(jlima): fix this
k("n", "<leader>t", [[:silent !tmux send-keys -t 2 c-p Enter<cr>]], silent)

--- visual selection search ---
k("v", "<enter>", [[y/\V<C-r>=escape(@",'/\')<CR><CR>]], silent)

-- open daily todo
k("n", "+", ":e ~/todo.md<cr>", opt)

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
k("n", "<C-d>", "<C-d>zz", opt)
k("n", "<C-u>", "<C-u>zz", opt)

--- paste over selection without overwriting clipboard
k("x", "p", "pgvy")

--- leave unnnamed reg alone when changing text
k("n", "c", '"ac')
k("n", "C", '"aC')

--- when using J keep cursor to the right
k({ "n", "v" }, "J", "mzJ`z")

--- terminal ---
k("t", "<Esc>", [[<c-\><c-n>]], silent)

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

--- shellcode ---
--- m(
--- 	"x",
--- 	"<space>h",
--- 	[[:s/\v\s+//ge<cr><bar> :s/\v(..)/\\\x\1/ge<cr><bar> :s/\v.*/buffer \+\= b"&"/ge<cr>:noh<cr>]],
--- 	silent
--- )

-- TODO(2024-06-05):  move keybindings to lua/plugins for autoloading

local packages = {
  "my.lazy",
  "my.vars",
  "my.settings",
  "my.cmds",
}

for _, mod in ipairs(packages) do
  local ok, _ = pcall(require, mod)
  if not ok then
    error("in init.lua, Module -> " .. mod .. " not loaded... ay..")
  end
end

vim.cmd([[cabbrev q1 q!]])
vim.cmd([[cabbrev Q1 q!]])
vim.cmd([[cabbrev Q q!]])
vim.cmd([[cabbrev qa1 qa!]])
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
