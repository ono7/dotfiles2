-- Follow the white rabbit...

-- TODO: 03-17-2021 | look at LSPkind for lua
-- TODO: 03-17-2021 | use wWbB  and oO to insert code ..more....

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

-- gravy
m("n", ";", ":", options)
m("v", ";", ":", options)
m("i", "jk", "<c-c>`^<cmd>noh<cr><c-g>", silent) -- `^ returns cursor to correct position
m("n", "gj", "j", options)
m("n", "gk", "k", options)
m("n", "Q", "@q", options)
m("v", "Q", ":'<,'>norm @q<cr>", options)
m("n", "<leader>d", ":bd!<cr><c-g>", options)
m("n", "<leader>q", ":qall!<cr>", options)
m("n", "<leader>w", ":write<cr>", silent)
m("n", "<tab>", ":bnext<cr>", silent)
m("n", "<s-tab>", ":bprevious<cr>", silent)
m("n", "Y", "y$", options)
m("v", "y", "mxy`x", options)
m("n", "<c-z>", "<nop>", options)
m("c", "<c-z>", "<nop>", options)
m("n", "cp", "yap<S-}>p", options)
m("n", "U", "<c-r>", options)

function _G.pre_format()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.bo.expandtab = true
  cmd([[%retab!]])
  cmd([[%s/\s\+$//e]])
  if vim.g.loaded_format == 1 then
    cmd([[Format]])
  end
  vim.api.nvim_win_set_cursor(0, pos)
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

-- hold my beer
require "autocmds"
require "pkg"
require "maps"
require "vars"
require "settings"

-- color and syntax related
cmd "colorscheme onehalfdark"
cmd "syntax enable"
cmd "syntax sync minlines=256"
cmd "syntax sync maxlines=300"
cmd "syntax on"

-- highlight yanked text
cmd [[au TextYankPost * silent! lua vim.highlight.on_yank{higroup="Cursor", timeout = 100 }]]

classic_cfg =
  [[
  " classic vim settings

  let mapleader = " "
  set nocompatible
  syntax enable
  syntax sync minlines=256
  syntax sync maxlines=300
  syntax on
  filetype plugin indent on

  nnoremap ; :
  vnoremap ; :
  inoremap <silent>jk <c-c>`^<cmd>noh<cr><c-g>
  nnoremap gj j
  nnoremap gk k
  nnoremap Q @q
  vnoremap Q :'<,'>norm @q<cr>
  nnoremap <leader>d :bd!<cr><c-g>
  nnoremap <leader>q :qall!<cr>
  nnoremap <leader>w :write<cr>
  nnoremap <silent><tab> :bnext<cr>
  nnoremap <silent><s-tab> :bprevious<cr>
  nnoremap Y y$
  vnoremap y mxy`x
  nnoremap <c-z> <nop>
  cnoremap <c-z> <nop>
  nnoremap cp yap<S-}>p
  nnoremap U <c-r>

  set autoindent
  set autoread
  set backspace=indent,eol,start
  set cmdheight=2
  set complete+=kspell complete-=i complete-=t
  set completeopt-=preview
  set diffopt=filler
  set directory=~/.tmp
  set display+=lastline
  set encoding=utf-8 nobomb
  set fileencoding=utf-8
  set fillchars+=vert:│
  set hidden
  set history=999
  set ignorecase
  set incsearch
  set laststatus=0
  set magic
  set nobackup nowritebackup noswapfile
  set nojoinspaces
  set list
  set listchars=tab:→\ ,trail:·,nbsp:•
  set noshowcmd
  set novisualbell noerrorbells
  set nowrap
  set nrformats-=octal nrformats+=alpha
  set nonumber numberwidth=2
  set pastetoggle=<F2>
  set ruler
  set scrolloff=2
  set shiftround shiftwidth=2
  set shortmess+=c
  set shortmess=atIoOsT
  set showmode
  set sidescrolloff=1
  set smartcase smarttab
  set spelllang=en_us
  set splitbelow
  set softtabstop=2 tabstop=2 textwidth=80 expandtab
  set timeout timeoutlen=500 ttimeout ttimeoutlen=50
  set undolevels=999
  set updatetime=250
  set wildignore+=*.o,*.obj,*.rbc,*.pyc,__pycache__/*,.git,.git/*
  set winaltkeys=no
  set lazyredraw
  set matchtime=0
  set nocursorcolumn
  set redrawtime=10000
  set ttyfast
  set clipboard=unnamed
  set fileformats=unix,dos
  if has('nvim')
    set inccommand=nosplit
    " pmenu/transparency/max items
    set pumheight=10 pumblend=0
    tnoremap jk <C-\><C-n>
  endif
]]

function classic()
  print(classic_cfg)
end
