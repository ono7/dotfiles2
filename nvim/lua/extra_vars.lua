M = {}

M.legacy_cfg =
  [[
" Follow the white rabbit...

let mapleader = " "
set synmaxcol=512
set nocompatible
syntax enable
syntax sync minlines=256
syntax sync maxlines=300
syntax on
filetype plugin indent on

" hold my beer

nnoremap <silent><cr> :noh<cr><c-g>
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>0
inoremap <m-b> <C-o>B
inoremap <m-f> <C-o>W
nnoremap cw ciw
nnoremap dw diw
nnoremap yw yiw
nnoremap k gk
nnoremap j gj
nnoremap <silent><c-n> :cnext<cr>
nnoremap <silent><c-p> :cprevious<cr>
nnoremap <leader>d :bd!<cr><c-g>
nnoremap <leader>q :qall!<cr>
nnoremap <leader>w :write<cr>

nnoremap <silent><M-j> :resize -2<cr>
nnoremap <silent><M-k> :resize +2<cr>
nnoremap <silent><M-h> :vertical resize -2<cr>
nnoremap <silent><M-l> :vertical resize +2<cr>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
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
nnoremap Q @q
vnoremap Q :'<,'>norm @q<cr>
nnoremap <silent><tab> :bnext<cr>
nnoremap <silent><s-tab> :bprevious<cr>
nnoremap Y y$
vnoremap y mxy`x
nnoremap <c-z> <nop>
cnoremap <c-z> <nop>
nnoremap cp yap<S-}>p
nnoremap U <c-r>
nnoremap H ^
nnoremap L g_
vnoremap H ^
vnoremap L g_
vnoremap <enter> y/\V<C-r>=escape(@",'/\')<CR><CR>

set autoindent
set path+=**
set autoread
set backspace=indent,eol,start
set cmdheight=2
set complete+=kspell complete-=i complete-=t
set completeopt-=preview
set diffopt=filler
set directory=/tmp
set display+=lastline
set encoding=utf-8
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
set foldmethod=manual
set fileformats=unix,dos

" function! BetterIndent()
"     if len(getline('.')) == 0
"         return "\"_ddO"
"     else
"         return "i"
"     endif
" endfunction
"
" nnoremap <expr> i BetterIndent()

if has('nvim')
  set inccommand=nosplit
  " pmenu/transparency/max items
  set pumheight=10 pumblend=0
  tnoremap <c-[> <C-\><C-n>
endif

function! <SID>RemoveWhiteSpace()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunction

command! RemoveWhiteSpace call <SID>RemoveWhiteSpace()

augroup _read
  autocmd!
  " restore last known position
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  autocmd BufEnter * silent! lcd %:p:h
  autocmd BufEnter * silent! set formatoptions=qlj
augroup END

augroup _write
  autocmd!
  autocmd BufWritePre * silent! :call <SID>RemoveWhiteSpace() | retab!
augroup END

augroup _resize
  autocmd!
  " resize splits when terminal size changes
  autocmd VimResized * :wincmd =
augroup END

hi!  Statement   ctermfg=1
hi!  String      ctermfg=2
hi!  Include     ctermfg=4
hi!  qfFileName  ctermfg=3
hi!  Comment     ctermfg=8  guifg=#5c6370
hi!  Search      ctermfg=7  ctermbg=8
hi!  Error       ctermfg=1  ctermbg=NONE
hi!  Whitespace  term=NONE  ctermbg=NONE   ctermfg=7      guifg=#e78a4e         guibg=NONE
hi!  MatchParen  term=NONE  ctermbg=8      ctermfg=7      cterm=bold,underline  gui=bold,underline  guifg=#dcdfe4  guibg=#3E4452
hi!  Visual      term=NONE  ctermbg=242    guibg=#3E4452  ctermfg=NONE          cterm=NONE
hi!  VertSplit   term=NONE  ctermbg=NONE gui=NONE guibg=NONE cterm=NONE

" Lima's vimrc, use at your own risk :)

]]

return M
