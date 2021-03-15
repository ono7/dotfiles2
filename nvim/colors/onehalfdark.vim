" ==============================================================================
"   Name:        One Half Dark
"   Author:      Son A. Pham <sp@sonpham.me>
"   Url:         https://github.com/sonph/onehalf
"   License:     The MIT License (MIT)
"
"   A dark vim color scheme based on Atom's One. See github.com/sonph/onehalf
"   for installation instructions, a light color scheme, versions for other
"   editors/terminals, and a matching theme for vim-airline.
" ==============================================================================

set background=dark
highlight clear
syntax reset

let g:colors_name="onehalfdark"
let colors_name="onehalfdark"

let s:black       = { "gui": "#282c34", "cterm": "0" }
let s:red         = { "gui": "#e06c75", "cterm": "1" }
let s:green       = { "gui": "#98c379", "cterm": "2" }
let s:yellow      = { "gui": "#e5c07b", "cterm": "3" }
let s:blue        = { "gui": "#61afef", "cterm": "4"  }
let s:purple      = { "gui": "#b67fd1", "cterm": "5" }
let s:cyan        = { "gui": "#56b6c2", "cterm": "6"  }
let s:white       = { "gui": "#dcdfe4", "cterm": "7" }

let s:fg          = s:white
let s:bg          = s:black

let s:comment_fg  = { "gui": "#5c6370", "cterm": "8" }
let s:gutter_bg   = { "gui": "#282c34", "cterm": "236" }
let s:gutter_fg   = { "gui": "#919baa", "cterm": "247" }

let s:cursor_line = { "gui": "#27303e", "cterm": "237" }
let s:color_col   = { "gui": "#313640", "cterm": "237" }

let s:selection   = { "gui": "#474e5d", "cterm": "239" }
let s:vertsplit   = { "gui": "#313640", "cterm": "237" }


function! s:h(group, fg, bg, attr)
  if type(a:fg) == type({})
    exec "hi " . a:group . " guifg=" . a:fg.gui . " ctermfg=" . a:fg.cterm
  else
    exec "hi " . a:group . " guifg=NONE cterm=NONE"
  endif
  if type(a:bg) == type({})
    exec "hi " . a:group . " guibg=" . a:bg.gui . " ctermbg=" . a:bg.cterm
  else
    exec "hi " . a:group . " guibg=NONE ctermbg=NONE"
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  else
    exec "hi " . a:group . " gui=NONE cterm=NONE"
  endif
endfun


" User interface colors {
call s:h("Normal", s:fg, s:bg, "")
call s:h("NonText", s:fg, "", "")

call s:h("Cursor", s:bg, s:blue, "")
call s:h("CursorColumn", "", s:cursor_line, "")
call s:h("CursorLine", "", s:cursor_line, "")

call s:h("LineNr", s:gutter_fg, s:gutter_bg, "")
call s:h("CursorLineNr", s:fg, "", "")

call s:h("DiffAdd", s:green, "", "")
call s:h("DiffChange", s:yellow, "", "")
call s:h("DiffDelete", s:red, "", "")
call s:h("DiffText", s:blue, "", "")

call s:h("IncSearch", s:bg, s:green, "")
call s:h("Search", s:bg, s:green, "")

call s:h("ErrorMsg", s:fg, "", "")
call s:h("ModeMsg", s:fg, "", "")
call s:h("MoreMsg", s:fg, "", "")
call s:h("WarningMsg", s:red, "", "")
call s:h("Question", s:purple, "", "")

call s:h("Pmenu", s:bg, s:fg, "")
call s:h("PmenuSel", s:fg, s:blue, "")
call s:h("PmenuSbar", "", s:selection, "")
call s:h("PmenuThumb", "", s:fg, "")

call s:h("SpellBad", s:red, "", "")
call s:h("SpellCap", s:yellow, "", "")
call s:h("SpellLocal", s:yellow, "", "")
call s:h("SpellRare", s:yellow, "", "")

call s:h("StatusLine", s:blue, s:cursor_line, "")
call s:h("StatusLineNC", s:comment_fg, s:cursor_line, "")
call s:h("TabLine", s:comment_fg, s:cursor_line, "")
call s:h("TabLineFill", s:comment_fg, s:cursor_line, "")
call s:h("TabLineSel", s:fg, s:bg, "")

" call s:h("IncSearch", s:bg, s:green, "")
call s:h("Visual", s:bg, s:green, "")
call s:h("VisualNOS", "", s:selection, "")

call s:h("ColorColumn", "", s:color_col, "")
call s:h("Conceal", s:fg, "", "")
call s:h("Directory", s:blue, "", "")
call s:h("VertSplit", s:vertsplit, s:vertsplit, "")
call s:h("Folded", s:fg, "", "")
call s:h("FoldColumn", s:fg, "", "")
call s:h("SignColumn", s:fg, "", "")

call s:h("MatchParen", s:blue, "", "underline")
call s:h("SpecialKey", s:fg, "", "")
call s:h("Title", s:green, "", "")
call s:h("WildMenu", s:fg, "", "")
" }


" Syntax colors {
call s:h("Comment", s:comment_fg, "", "")
call s:h("Constant", s:cyan, "", "")
call s:h("String", s:green, "", "")
call s:h("Character", s:green, "", "")
call s:h("Number", s:yellow, "", "")
call s:h("Boolean", s:yellow, "", "")
call s:h("Float", s:yellow, "", "")

call s:h("Identifier", s:red, "", "")
call s:h("Function", s:blue, "", "")
call s:h("Statement", s:purple, "", "")

call s:h("Conditional", s:red, "", "")
call s:h("Repeat", s:red, "", "")
call s:h("Label", s:purple, "", "")
call s:h("Operator", s:fg, "", "")
call s:h("Keyword", s:red, "", "")
call s:h("Exception", s:purple, "", "")

call s:h("PreProc", s:yellow, "", "")
call s:h("Include", s:blue, "", "")
call s:h("Define", s:purple, "", "")
call s:h("Macro", s:purple, "", "")
call s:h("PreCondit", s:yellow, "", "")

call s:h("Type", s:yellow, "", "")
call s:h("StorageClass", s:yellow, "", "")
call s:h("Structure", s:yellow, "", "")
call s:h("Typedef", s:yellow, "", "")

call s:h("Special", s:blue, "", "")
call s:h("SpecialChar", s:fg, "", "")
call s:h("Tag", s:fg, "", "")
call s:h("Delimiter", s:fg, "", "")
call s:h("SpecialComment", s:fg, "", "")
call s:h("Debug", s:fg, "", "")
call s:h("Underlined", s:fg, "", "")
call s:h("Ignore", s:fg, "", "")
call s:h("Error", s:red, s:gutter_bg, "")
call s:h("Todo", s:purple, "", "")
" }


" Plugins {
" GitGutter
call s:h("GitGutterAdd", s:green, s:gutter_bg, "")
call s:h("GitGutterDelete", s:red, s:gutter_bg, "")
call s:h("GitGutterChange", s:yellow, s:gutter_bg, "")
call s:h("GitGutterChangeDelete", s:red, s:gutter_bg, "")
" Fugitive
call s:h("diffAdded", s:green, "", "")
call s:h("diffRemoved", s:red, "", "")
" }

" Git {
call s:h("gitcommitComment", s:comment_fg, "", "")
call s:h("gitcommitUnmerged", s:red, "", "")
call s:h("gitcommitOnBranch", s:fg, "", "")
call s:h("gitcommitBranch", s:purple, "", "")
call s:h("gitcommitDiscardedType", s:red, "", "")
call s:h("gitcommitSelectedType", s:green, "", "")
call s:h("gitcommitHeader", s:fg, "", "")
call s:h("gitcommitUntrackedFile", s:cyan, "", "")
call s:h("gitcommitDiscardedFile", s:red, "", "")
call s:h("gitcommitSelectedFile", s:green, "", "")
call s:h("gitcommitUnmergedFile", s:yellow, "", "")
call s:h("gitcommitFile", s:fg, "", "")

hi link gitcommitNoBranch gitcommitBranch
hi link gitcommitUntracked gitcommitComment
hi link gitcommitDiscarded gitcommitComment
hi link gitcommitSelected gitcommitComment
hi link gitcommitDiscardedArrow gitcommitDiscardedFile
hi link gitcommitSelectedArrow gitcommitSelectedFile
hi link gitcommitUnmergedArrow gitcommitUnmergedFile
" }

" Fix colors in neovim terminal buffers {
  if has('nvim')
    let g:terminal_color_0 = s:black.gui
    let g:terminal_color_1 = s:red.gui
    let g:terminal_color_2 = s:green.gui
    let g:terminal_color_3 = s:yellow.gui
    let g:terminal_color_4 = s:blue.gui
    let g:terminal_color_5 = s:purple.gui
    let g:terminal_color_6 = s:cyan.gui
    let g:terminal_color_7 = s:white.gui
    let g:terminal_color_8 = s:black.gui
    let g:terminal_color_9 = s:red.gui
    let g:terminal_color_10 = s:green.gui
    let g:terminal_color_11 = s:yellow.gui
    let g:terminal_color_12 = s:blue.gui
    let g:terminal_color_13 = s:purple.gui
    let g:terminal_color_14 = s:cyan.gui
    let g:terminal_color_15 = s:white.gui
    let g:terminal_color_background = s:bg.gui
    let g:terminal_color_foreground = s:fg.gui
  endif
" }


hi!  Red     ctermfg=1    guifg=#e06c75
hi!  Green   ctermfg=2    guifg=#56b6c2
hi!  Yellow  ctermfg=3    guifg=#e5c07b
hi!  Blue    ctermfg=4    guifg=#61afef
hi!  Purple  ctermfg=5    guifg=#b67fd1
hi!  Aqua    ctermfg=6    guifg=#56b6c2
hi!  Orange  ctermfg=208  guifg=#e78a4e

hi!  RedItalic      cterm=italic  gui=italic  ctermfg=1  guifg=#e06c75
hi!  OrangeItalic   cterm=italic  gui=italic  ctermfg=208  guifg=#e78a4e
hi!  YellowItalic   cterm=italic  gui=italic  ctermfg=3  guifg=#e5c07b
hi!  GreenItalic    cterm=italic  gui=italic  ctermfg=2  guifg=#a9b665
hi!  AquaItalic     cterm=italic  gui=italic  ctermfg=6  guifg=#7daea3
hi!  BlueItalic     cterm=italic  gui=italic  ctermfg=4  guifg=#61afef
hi!  PurpleItalic   cterm=italic  gui=italic  ctermfg=5  guifg=#b67fd1
hi!  NormalItalic   cterm=italic  gui=italic  ctermfg=223  guifg=#d4be98
hi!  CommentItalic  cterm=italic  gui=italic  ctermfg=245  guifg=#5c6370
hi!  RedBold        cterm=bold    gui=bold    ctermfg=1  guifg=#e06c75
hi!  OrangeBold     cterm=bold    gui=bold    ctermfg=208  guifg=#e78a4e
hi!  YellowBold     cterm=bold    gui=bold    ctermfg=3  guifg=#d8a657
hi!  GreenBold      cterm=bold    gui=bold    ctermfg=2  guifg=#98c379
hi!  AquaBold       cterm=bold    gui=bold    ctermfg=6  guifg=#89b482
hi!  BlueBold       cterm=bold    gui=bold    ctermfg=4  guifg=#61afef
hi!  PurpleBold     cterm=bold    gui=bold    ctermfg=5  guifg=#b67fd1
hi!  NormalBold     cterm=bold    gui=bold    ctermfg=223  guifg=#dcdfe4
hi!  CommentBold    cterm=bold    gui=bold    ctermfg=245  guifg=#95c637

hi!  CursorLineNr   ctermfg=246  ctermbg=NONE   guifg=#dcdfe4  guibg=NONE
hi!  Folded         ctermfg=245  ctermbg=NONE   guifg=#95c637  guibg=NONE
hi!  Cursor         gui=NONE     cterm=NONE     ctermbg=208    ctermfg=1      guifg=#1d2021  guibg=#e78a4e
hi!  MsgArea        ctermfg=246  ctermbg=NONE   guifg=#9297a1  guibg=NONE
hi!  Pmenu          ctermbg=235  ctermfg=8      guibg=#2c3748  guifg=#9297a1
hi!  PmenuSel       ctermbg=239  ctermfg=7      guibg=#313640 guifg=#9297a1  gui=reverse
hi!  CommentNormal  ctermfg=8    guifg=#95c637
" hi!  Visual         ctermfg=234  ctermbg=5      guifg=NONE     guibg=#3e4451
" hi!  Pmenu          ctermbg=235  ctermfg=8      guibg=#313640  guifg=#9297a1
" hi!  IncSearch         ctermfg=234  ctermbg=5      guifg=NONE     guibg=#3e4451
" hi!  Search      ctermfg=234  ctermbg=5      guifg=NONE     guibg=#3a5286

" gutter
hi!  SignColumn  ctermfg=223   ctermbg=NONE   guifg=#d4be98  guibg=NONE
hi!  RedSign     ctermfg=1     ctermbg=NONE   guifg=#e06c75  guibg=NONE
hi!  YellowSign  ctermbg=NONE  guifg=#e5c07b  guibg=NONE
hi!  BlueSign    ctermfg=4     ctermbg=NONE   guifg=#61afef  guibg=NONE
hi!  link        lineNr        Comment

" markdown
hi!  link  markdownH1             GreenBold
hi!  link  markdownH2             BlueBold
hi!  link  markdownH3             OrangeBold
hi!  link  markdownH4             PurpleBold
hi!  link  markdownH5             YellowBold
hi!  link  markdownH6             RedBold
hi!  link  markdownUrl            PurpleBold
hi!  link  markdownCodeDelimiter  Comment
hi!  link  VimwikiHeader1         markdownH1
hi!  link  VimwikiHeader2         markdownH2
hi!  link  VimwikiHeader3         markdownH3
hi!  link  VimwikiHeader4         markdownH4
hi!  link  VimwikiHeader5         markdownH5
hi!  link  VimwikiHeader6         markdownH6
hi!  link  VimwikiPre             Comment
hi!  link  VimwikiLink            Purple
hi!  link  ALEWarningSign         Yellow
hi!  link  ALEErrorSign           YellowBold
hi!  link  Repeat                 RedItalic
hi!  link  Conditional            RedItalic
hi!  link  EndOfBuffer            Comment
hi!  link  Include                BlueItalic
hi!  link  Keyword                RedItalic
hi!  link  SpecialChar            Purple
hi!  link  Delimiter              Purple
hi!  link  TSPunctDelimiter       Normal
hi!  link  Operator               Blue
hi!  link  TSKeywordOperator      RedItalic
" hi!  link  TSFuncBuiltin          NormalItalic
hi!  link  TSParameter            Normal
hi!  link  Function               Normal
hi!  link  TSConstructor          Orange
hi!  link  TSType                 Orange
hi!  TSFuncBuiltin ctermfg=223 guifg=#d4be98
hi!  TSVariableBuiltin  gui=italic  ctermfg=245  guifg=#d4be98

hi!  VertSplit ctermbg=NONE guibg=NONE

silent!  syn  clear  Normal
silent!  syn  clear  Comment

hi!  Normal       ctermbg=0    guibg=none     guifg=none
hi!  Comment      ctermfg=8    guifg=#5c6370
hi!  link         SpecialKey   Orange
hi!  link         NonText      Orange
hi!  fzf_info     ctermfg=6
hi!  fzf_bg       ctermfg=0    guifg=#282c34
hi!  fzf_bg_plus  ctermbg=237  guibg=#313640
hi!  fzf_spinner  ctermfg=6

hi!  TermCursorNC  guibg=Purple  guifg=white  ctermbg=1  ctermfg=15
hi!  trans         guibg=Purple  guifg=white  ctermbg=1  ctermfg=15
