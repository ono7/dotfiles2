M = {}

M.legacy_cfg =
  [[

" classic vim settings
let mapleader = " "
set nocompatible
syntax enable
syntax sync minlines=256
syntax sync maxlines=300
syntax on
filetype plugin indent on
nnoremap ' `
nnoremap / ms/
xnoremap / ms/
nnoremap ? ms?
xnoremap ? ms?
nnoremap ma mA
nnoremap mb mB
nnoremap mc mC
nnoremap mm mM
nnoremap 'a 'A
nnoremap 'b 'B
nnoremap 'c 'C
nnoremap 'm 'M
nnoremap ; :
vnoremap ; :
nnoremap : ;
vnoremap : ;
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

return M
