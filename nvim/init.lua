--- Follow the white Rabbit...   🐇

--- hold my beer ---

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

local cmd, m, k = vim.cmd, vim.api.nvim_set_keymap, vim.keymap.set
local opt = { noremap = true }
local silent = { noremap = true, silent = true }

-- if nothing else, this are the bare minimum necessities
vim.opt.path:append({ "**" })
vim.opt.shell = "zsh"
vim.opt.clipboard:append("unnamedplus")
vim.opt.wrap = false

--- if syntax is on/enabled treesitter has issues
--- other weird things happen, like lsp not starting automatically etc
--- see https://thevaluable.dev/tree-sitter-neovim-overview/
vim.opt.syntax = "off"

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

-- open daily todo
k("n", "+", ":e ~/todo.md<cr>", opt)

--- vs last paste
k("n", "gp", "`[v`]", silent)

--- keep cursor in same position when yanking in visual
k("x", "y", [[ygv<Esc>]], silent)

vim.opt.winbar = "%=%M %-.45f %-m {%{get(b:, 'branch_name', '')}}"

-- might need this in the future
vim.g.skip_ts_context_commentstring_module = true

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

require("my.lazy-bootstrap")
require("my.keymaps")
require("my.helper-functions")

-- TODO(2024-06-05):  move keybindings to lua/plugins for autoloading

local packages = {
  "my.lazy",
  "my.vars",
  "my.settings",
  "my.cmds",
}

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

for _, mod in ipairs(packages) do
  local ok, err = pcall(require, mod)
  if not ok then
    error("in init.lua, Module -> " .. mod .. " not loaded... ay.." .. err)
  end
end

vim.cmd([[cabbrev q1 q!]])
vim.cmd([[cabbrev Q1 q!]])
vim.cmd([[cabbrev Q q!]])
vim.cmd([[cabbrev qa1 qa!]])
vim.cmd([[cabbrev qall1 qall!]])

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
