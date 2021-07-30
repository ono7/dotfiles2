M = {}

M.legacy_cfg =
  [[
" Follow the white rabbit

let mapleader = ";"
let g:loaded_matchit = 1
let g:loaded_logiPat = 1
let g:loaded_rrhelper = 1
let g:loaded_tarPlugin = 1
let g:loaded_gzip = 1
let g:loaded_zipPlugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_shada_plugin = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_remote_plugins = 1

let g:diff_translations = 0
let g:pyindent_open_paren = '0'
let g:pyindent_nested_paren = '&sw'
let g:pyindent_continue = '&sw'

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20

" remove ~
let &fcs='eob: '

set synmaxcol=512
set nocompatible
syntax enable
syntax sync minlines=256
syntax sync maxlines=300
filetype plugin indent on
syntax on

""" hold my beer """

inoremap ` ``<left>
inoremap ( ()<left>
inoremap { {}<left>
inoremap [ []<left>
inoremap <c-d> <cr><esc>O

inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"

cnoremap <C-A> <Home>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
nnoremap <silent><cr> :noh<cr>1<c-g>
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>^
inoremap <m-b> <C-o>B
inoremap <m-f> <C-o>W
nnoremap gg gg1<c-g>
nnoremap G G1<c-g>
nnoremap yw yiw
nnoremap <silent><c-n> :cnext<cr>
nnoremap <silent><c-p> :cprevious<cr>
nnoremap <leader>d :bd!<cr>1<c-g>
nnoremap <leader>q :%bd!<cr>
nnoremap <leader>w :write<cr>1<c-g>

nnoremap <silent>gp `[v`]
nnoremap <silent><Esc>j :resize -2<cr>
nnoremap <silent><Esc>k :resize +2<cr>
nnoremap <silent><Esc>l :vertical resize -2<cr>
nnoremap <silent><Esc>h :vertical resize +2<cr>
nnoremap <silent><Esc>t :Vex<cr>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap ' `
nnoremap ma mA
nnoremap mb mB
nnoremap mc mC
nnoremap mm mM
nnoremap ms mS
nnoremap 'a `A
nnoremap 'b `B
nnoremap 'c `C
nnoremap 'm `M
nnoremap 's `S
nnoremap Q @q
vnoremap Q :'<,'>norm @q<cr>
nnoremap Y y$
nnoremap D d$
vnoremap y mxy`x
nnoremap <c-z> <nop>
cnoremap <c-z> <nop>
nnoremap cp yap<S-}>p
nnoremap U <c-r>
nnoremap <c-a> ^
nnoremap <c-e> g_
vnoremap <c-a> ^
vnoremap <c-e> g_
vnoremap <enter> y/\V<C-r>=escape(@",'/\')<CR><CR>

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : "\<C-n>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <leader>t :!tmux send-keys -t 2 c-p Enter<cr> :redraw!<cr>

set completeopt=menuone

set notitle
set tags+=./tags,tags,.tags,./vtags,.vtags
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
set history=50
set ignorecase
set incsearch
set nohlsearch
set laststatus=0
set magic
set nobackup nowritebackup noswapfile
set nojoinspaces
set list
set listchars=tab:→\ ,trail:·,nbsp:•
set noshowcmd
set showtabline=0
set novisualbell noerrorbells
set nowrap
set nrformats-=octal nrformats+=alpha
set nonumber numberwidth=2
set ruler
set shiftround shiftwidth=2
set shortmess=atcIoOsT
set showmode
set sidescrolloff=1
set smartcase smarttab
set spelllang=en_us
set splitbelow
set splitright
set softtabstop=2 tabstop=2 textwidth=0 expandtab
set timeout timeoutlen=500 ttimeout ttimeoutlen=50
set undolevels=999
set updatetime=1000
set wildignore+=.tags,tags,vtags,*.o,*.obj,*.rbc,*.pyc,__pycache__/*,.git,.git/*,*.class
set wildmenu
set winaltkeys=no
set lazyredraw
set matchtime=0
set matchpairs = (:),{:},[:],<:>

set nocursorcolumn
set redrawtime=10000
set ttyfast
set foldmethod=indent
set nofoldenable
set fileformats=unix,dos
set autoindent
set nolisp

if has('unnamedplus')
  set clipboard+=unnamedplus
else
  set clipboard=unnamed
endif

if has('nvim')
  set inccommand=nosplit
  " pmenu/transparency/max items
  set pumheight=10 pumblend=0
  tnoremap <c-[> <C-\><C-n>
  set clipboard+=unnamedplus
endif

if &diff
  if has('nvim-0.3.2') || has("patch-8.1.0360")
      set diffopt=filler,internal,algorithm:histogram,indent-heuristic
  endif
  set number
endif


function! <SID>RemoveWhiteSpace()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunction

command! RemoveWhiteSpace call <SID>RemoveWhiteSpace()

augroup _init
  autocmd!
  autocmd BufWinEnter * if line2byte(line("$") + 1) > 800000 | syntax clear | setlocal nowrap | setlocal eventignore=all | endif
  autocmd BufEnter * silent! set formatoptions=qnlj
augroup END

augroup _read
  autocmd!
  " restore last known position
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

augroup _write
  autocmd!
  autocmd BufWritePre * silent! :call <SID>RemoveWhiteSpace() | retab!
augroup END

augroup _resize
  autocmd!
  autocmd VimResized * :wincmd =
augroup END

augroup _files
  autocmd!
  " setlocal indentexpr=GetPythonIndent(v:lnum)
  autocmd FileType python setlocal sw=4 ts=4 et softtabstop=4 tw=0 nowrap autoindent nolisp
  autocmd FileType python setlocal indentkeys=!^F,o,O,<:>,0),0],0},=elif,=except
  " autocmd FileType * setlocal sw=2 ts=2 et softtabstop=2 tw=0 nowrap autoindent nolisp
  autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
augroup END

command! Mktags !ctags -R .

hi!  MatchParen    term=none     ctermbg=8      ctermfg=7       cterm=bold,underline  gui=bold,underline  guifg=#dcdfe4  guibg=#3E4452
hi!  Statement     ctermfg=1
hi!  String        ctermfg=2
hi!  Include       ctermfg=4
hi!  qfFileName    ctermfg=3
hi!  Comment       ctermfg=8     guifg=#5C6370
hi!  Search        ctermfg=7     ctermbg=8      guibg=none
hi!  Error         ctermfg=1     ctermbg=none
hi!  link          ErrorMsg      Error
hi!  Whitespace    term=none     ctermbg=none   ctermfg=15       guifg=#939eb3         guibg=none
hi!  Visual        term=none     ctermbg=242    guibg=#3E4452   ctermfg=none          cterm=none
hi!  VertSplit     term=none     ctermbg=none   ctermfg=8       gui=none              guibg=none          guifg=#5C6370  cterm=none
hi!  PmenuSel      ctermbg=238   guibg=#3E4452  ctermfg=none    guifg=none
hi!  Pmenu         ctermfg=242   ctermbg=0      guibg=DarkGrey
hi!  link          LineNr        Comment
hi!  link          CursorLineNr  String
hi!  EndOfBuffer   ctermbg=none  guifg=#23272e  ctermfg=236
hi!  link          MsgArea       Comment
hi!  ModeMsg       term=italic   ctermfg=8      gui=italic     guifg=#939eb3
hi!  MoreMsg       term=italic   ctermfg=7      gui=italic     guifg=#939eb3
hi!  MsgArea       ctermfg=8     guifg=#939eb3
hi!  DiffAdd       ctermfg=0     ctermbg=2      gui=none        guifg=Black           guibg=#98C379
hi!  DiffDelete    ctermfg=1     ctermbg=0      gui=none        guifg=Black           guibg=#E06C75
hi!  DiffChange    ctermfg=none  ctermbg=none   gui=none        guifg=Black           guibg=#61AFEF
hi!  DiffText      ctermfg=0     ctermbg=3      gui=none        guifg=Black           guibg=#e5c07b
" hi!  DiffAdd       ctermfg=0     ctermbg=2      gui=none        guifg=Black           guibg=#98C379
" hi!  DiffDelete    ctermfg=0     ctermbg=1      gui=none        guifg=Black           guibg=#E06C75
" hi!  DiffChange    ctermfg=0     ctermbg=4      gui=none        guifg=Black           guibg=#61AFEF
" hi!  DiffText      ctermfg=0     ctermbg=3      gui=none        guifg=Black           guibg=#e5c07b
hi!  Folded        ctermfg=8     guifg=#5c6370  ctermbg=none    guibg=none            gui=bold            term=bold
hi!  FoldColumn    ctermbg=none  guibg=#3E4452
hi!  SignColumn    ctermfg=7     ctermbg=none
hi!  link          CursorLine    Search
hi!  link          StatusLine    Search
hi!  StatusLineNC  ctermfg=0     ctermbg=7      guibg=none
hi!  link          Todo          Underlined

filetype plugin indent on

" python indent file in ~/.dotfiles/nvim/indent/python.vim -> ~/.vim/indent/python.vim"

" Lima's vimrc, use at your own risk :)

]]

return M
