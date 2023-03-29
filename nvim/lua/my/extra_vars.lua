M = {}
M.legacy_cfg = [===[
" Follow the white rabbit

set nocompatible

set t_Co=256

let mapleader = " "
let g:loaded_matchit = 1
let g:loaded_matchparen = 1
let g:loaded_logiPat = 1
let g:loaded_rrhelper = 1
let g:loaded_tarPlugin = 1
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
let g:NetrwIsOpen=0

function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction

nnoremap <silent>,t :call ToggleNetrw()<CR>

" remove ~
let &fcs='eob: '

set synmaxcol=512
syntax enable
syntax sync minlines=256
syntax sync maxlines=300
filetype plugin indent on
syntax on

""" hold my beer """

" inoremap ` ``<left>
" inoremap ( ()<left>
" inoremap { {}<left>
" inoremap [ []<left>

" j, k   Store relative line number jumps in the jumplist. c-o, c-i
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
" inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"
" inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"

" skip over \" and \' if they are inline
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'"
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\""
inoremap <expr> ` strpart(getline('.'), col('.')-1, 1) == "\`" ? "\<Right>" : "\`"

inoremap <expr> <bs> <sid>remove_pair()
inoremap <expr> <enter> <sid>indent_ret()

imap <c-h> <bs>

function! GoFmt()
  cexpr system('gofmt -e -w ' . expand('%'))
  edit!
endfunction

function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register Cm call CopyMatches(<q-reg>)

function s:remove_pair() abort
  let pair = getline('.')[ col('.')-2 : col('.')-1 ]
  return stridx('""''''()[]<>{}``', pair) % 2 == 0 ? "\<del>\<c-h>" : "\<bs>"
endfunction

function s:indent_ret() abort
  let pair = getline('.')[ col('.')-2 : col('.')-1 ]
  return stridx('()[]{}', pair) % 2 == 0 ? "\<cr>\<esc>O" : "\<cr>"
endfunction

" surround mappings
nnoremap s" ciw"<c-r><c-p>""
nnoremap s' ciw'<c-r><c-p>"'

nnoremap <leader>p \"_dP
nnoremap <c-j> <C-W><C-J>
nnoremap <c-k> <C-W><C-K>
nnoremap <c-l> <C-W><C-L>
nnoremap <c-h> <C-W><C-H>

" save some keystrokes
" nnoremap ; :
" xnoremap ; :

noremap v <c-v>
vunmap v

inoremap <C-c> <Esc>

" change local cd per buffer
nnoremap <leader>cd :lcd %:h<CR>

cnoremap <C-A> <Home>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
nnoremap <silent><cr> :noh<cr>1<c-g>
" inoremap <C-e> <C-o>$
" inoremap <C-a> <C-o>^
" inoremap <m-b> <C-o>B
" inoremap <m-f> <C-o>W
nnoremap <silent><c-n> :cnext<cr>
nnoremap <silent><c-p> :cprevious<cr>
nnoremap <leader>d :bd!<cr>
nnoremap <leader>q :qall!<cr>
nnoremap <leader>w :w<cr>

" return cursor position after yank in v-mode
vnoremap y ygv<Esc>

nnoremap <silent><Esc>j :resize -2<cr>
nnoremap <silent><Esc>k :resize +2<cr>
nnoremap <silent><Esc>l :vertical resize -2<cr>
nnoremap <silent><Esc>h :vertical resize +2<cr>
nnoremap ' `
nnoremap ma mA
nnoremap mb mB
nnoremap mc mC
nnoremap mm mM
" '" -> go to mark and restore last cursor postion
nnoremap 'a `A'"
nnoremap 'b `B'"
nnoremap 'c `C'"
nnoremap 'm `M'"
nnoremap Q @q
vnoremap Q :'<,'>norm @q<cr>
" make dot work on many visual sel lines
vnoremap . :norm.<CR>
nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <c-d> <c-d>zz
nnoremap <c-u> <c-u>zz
nnoremap D d$
nnoremap <c-z> <nop>
cnoremap <c-z> <nop>
nnoremap cp yap<S-}>p
nnoremap U <c-r>
nnoremap <c-e> g_
nnoremap <silent><Tab> :bnext<cr>
nnoremap <silent><S-Tab> :bprev<cr>

" select last paste in visual mode
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

nnoremap gt :e ~/notes.md<cr>

vnoremap <enter> y/\V<C-r>=escape(@",'/\')<CR><CR>

nnoremap <leader>b :ls<cr>:b<space>

if executable('rg')
    set grepprg=rg\ --no-heading\ --color=never\ --smart-case\ --vimgrep\ -g\ '!.git'
endif

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! Osc52()
  let buffer=system('base64 -w0', @0) " -w0 disable 76 char wrap
  let buffer='\ePtmux;\e\e]52;c; '.buffer.'\x07\e\\'
  silent exe "!echo -ne ".shellescape(buffer)." > ".shellescape(g:tty)
endfunction

nnoremap <leader>y :call Osc52()<CR>

" inoremap <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : "\<C-n>"
" inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <leader>t :!tmux send-keys -t 2 c-p Enter<cr> :redraw!<cr>

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent lgrep' : 'lgrep'

set completeopt=menu,menuone,longest
set pumheight=10
set notitle
set virtualedit=all
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
set tags+=./tags,tags,.tags,./vtags,.vtags
set path+=**
set whichwrap+=<>[]hl
set autoread
set backspace=indent,eol,start
set cmdheight=1
set complete+=kspell complete-=i
set diffopt=filler
set directory=
set viminfo='20,<1000,s1000,:1000,/1000,h,r/tmp
set display+=lastline
set encoding=utf-8
set fileencoding=utf-8
set fillchars+=vert:│,diff:╱
set hidden
set history=1000
set ignorecase
set incsearch
set nohlsearch
set mouse=n
set laststatus=0
set magic
set nobackup nowritebackup noswapfile
set nojoinspaces
set list
set listchars=tab:\ \ ,conceal:\ ,trail:•,nbsp:·
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
set timeout ttimeout
set timeoutlen=500 ttimeoutlen=0
set undolevels=999
set undodir=~/vim_undo
set undofile
set updatetime=1000
set wildignore+=.tags,tags,vtags,*.o,*.obj,*.rbc,*.pyc,__pycache__/*,.git,.git/*,*.class
set wildmenu
set winaltkeys=no
set lazyredraw
set matchtime=0
set matchpairs=(:),{:},[:],<:>

set nocursorcolumn
set redrawtime=10000
set ttyfast
set foldmethod=indent
set nofoldenable
set fileformats=unix,dos
set autoindent
set nolisp
set iskeyword+=-

if has('unnamedplus')
  set clipboard+=unnamedplus
else
  set clipboard=unnamed
endif

if has('nvim')
  packadd cfilter
  set inccommand=nosplit
  " pmenu/transparency/max items
  set pumheight=10 pumblend=0
  tnoremap <c-[> <C-\><C-n>
  set clipboard+=unnamedplus
endif

if has('nvim-0.3.2') || has("patch-8.1.0360")
  set completeopt=menu,menuone,longest
  packadd cfilter
end

if &diff
  if has('nvim-0.3.2')
    set diffopt=filler,internal,algorithm:histogram,indent-heuristic
  endif
  set number
endif

function! <SID>RemoveWhiteSpace()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
  update
endfunction

command! RemoveWhiteSpace call <SID>RemoveWhiteSpace()

function! <SID>mySyntax()
  syntax match myCyanBold /[*.,:;]/
  " syntax match myBold /[*.,:;]/
  " syntax match myBlue /[]/
  syntax match myCyan /[\[\]=<!>-]/
  syntax match myYellow /[{}]/
  " syntax match myRedBold /[()]/
endfu

augroup _del_hidden_buffer
  au!
  au FileType netrw setlocal bufhidden=wipe
augroup end

augroup _read
  autocmd!
  " restore last known position
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

augroup _write
  autocmd!
  autocmd BufWritePre * silent! :retab!
augroup END

augroup _resize
  autocmd!
  autocmd VimResized * :wincmd =
augroup END

augroup _quickfix
  autocmd!
  autocmd QuickFixCmdPost [^l]* copen 6 | nnoremap <buffer> <CR> <CR>
  autocmd QuickFixCmdPost l* lwindow 6 | nnoremap <buffer> <CR> <CR>
augroup END

augroup _files
  autocmd!
  autocmd FileType python setlocal sw=4 ts=4 et softtabstop=4 tw=0 nowrap autoindent nolisp
  autocmd FileType python setlocal indentkeys=!^F,o,O,<:>,0),0],0},=elif,=except
  autocmd FileType python setlocal suffixadd+=.py
  " help gf find files missing extentions
  autocmd FileType go setlocal suffixadd+=.go
  autocmd FileType yaml setlocal suffixadd+=.yml
  autocmd FileType make setlocal sw=4 ts=4 noet sts=4 tw=0 nowrap autoindent nolisp
  autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
  autocmd filetype * :call <SID>mySyntax()
augroup END

command! Mktags !ctags -R .

hi!  MatchParen    ctermbg=7     ctermfg=1     cterm=bold

if !has("patch-7.4.2213")
  hi! link NonText Comment
end

augroup _init
  autocmd!
  autocmd BufWinEnter * if line2byte(line("$") + 1) > 800000 | setlocal syntax=OFF nowrap noundofile noswapfile foldmethod=manual | endif
  autocmd BufEnter * silent! set formatoptions=qnlj
  autocmd BufEnter * :call <SID>mySyntax()
augroup END

" python indent file in ~/.dotfiles/nvim/indent/python.vim -> ~/.vim/indent/python.vim"

" Lima's vimrc, use at your own risk :)

]===]

M.legacy_min = [===[
set nocompatible
set t_Co=256
let mapleader = " "
set synmaxcol=512
syntax enable
syntax sync minlines=256
syntax sync maxlines=300
filetype plugin indent on
syntax on
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'"
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\""
inoremap <expr> ` strpart(getline('.'), col('.')-1, 1) == "\`" ? "\<Right>" : "\`"
imap <c-h> <bs>
augroup _quickfix
  autocmd!
  autocmd QuickFixCmdPost [^l]* copen 6 | nnoremap <buffer> <CR> <CR>
  autocmd QuickFixCmdPost l* lwindow 6 | nnoremap <buffer> <CR> <CR>
augroup END
nnoremap s" ciw"<c-r><c-p>""
nnoremap s' ciw'<c-r><c-p>"'
nnoremap <c-j> <C-W><C-J>
nnoremap <c-k> <C-W><C-K>
nnoremap <c-l> <C-W><C-L>
nnoremap <c-h> <C-W><C-H>
noremap v <c-v>
vunmap v
cnoremap <C-A> <Home>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
nnoremap <silent><cr> :noh<cr>1<c-g>
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>^
nnoremap <silent><c-n> :cnext<cr>
nnoremap <silent><c-p> :cprevious<cr>
nnoremap ,d :bd!<cr>
nnoremap ,q :qall!<cr>
nnoremap <leader>w :w<cr>
vnoremap y ygv<Esc>
nnoremap ' `
nnoremap ma mA
nnoremap mb mB
nnoremap mc mC
nnoremap mm mM
nnoremap 'a `A'"
nnoremap 'b `B'"
nnoremap 'c `C'"
nnoremap 'm `M'"
nnoremap Q @q
vnoremap Q :'<,'>norm @q<cr>
vnoremap . :norm.<CR>
nnoremap Y y$
nnoremap D d$
nnoremap <c-z> <nop>
cnoremap <c-z> <nop>
nnoremap cp yap<S-}>p
nnoremap U <c-r>
nnoremap <c-e> g_
nnoremap <silent><Tab> :bnext<cr>
nnoremap <silent><S-Tab> :bprev<cr>
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
vnoremap <enter> y/\V<C-r>=escape(@",'/\')<CR><CR>
nnoremap <leader><leader> :ls<cr>:b<space>
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent lgrep' : 'lgrep'
set completeopt=menu,menuone,longest
set pumheight=10
set virtualedit=all
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
set tags+=./tags,tags,.tags,./vtags,.vtags
set path+=**
set whichwrap+=<>[]hl
set autoread
set backspace=indent,eol,start
set complete+=kspell complete-=i
set diffopt=filler
set directory=
set viminfo='20,<1000,s1000,:1000,/1000,h,r/tmp
set display+=lastline
set encoding=utf-8
set fileencoding=utf-8
set fillchars+=vert:│,diff:╱
set hidden
set history=1000
set ignorecase incsearch nohlsearch
set mouse=n
set laststatus=0
set magic
set nobackup nowritebackup noswapfile
set nojoinspaces list
set listchars=tab:\ \ ,conceal:\ ,trail:•,nbsp:·
set showtabline=0
set novisualbell noerrorbells
set nowrap showmode noshowcmd
set nrformats-=octal nrformats+=alpha
set number relativenumber numberwidth=2 ruler shiftround shiftwidth=2
set shortmess=atcIoOsT
set smartcase smarttab
set spelllang=en_us
set splitbelow splitright
set softtabstop=2 tabstop=2 textwidth=0 expandtab
set timeout ttimeout
set timeoutlen=500 ttimeoutlen=0
set undodir=~/vim_undo
set undofile wildmenu
set updatetime=1000
set wildignore+=.tags,tags,vtags,*.o,*.obj,*.rbc,*.pyc,__pycache__/*,.git,.git/*,*.class
set winaltkeys=no
set lazyredraw ttyfast
set matchtime=0
set matchpairs=(:),{:},[:],<:>
set autoindent
augroup _read
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
]===]
return M
