-- setup locals

local gs, g = vim.api.nvim_set_var, vim.g

-- nvim-completion

g.completion_trigger_keyword_length = 1 -- default = 1
g.completion_sorting = "length"

-- lsp

g.completion_matching_strategy_list = {"exact", "substring", "fuzzy"}

-- vimwiki

g.vimwiki_global_ext = 1
-- g.mywiki = {}
-- g.mywiki.path = "~/wiki/"
-- g.mywiki.syntax = "markdown"
-- g.mywiki.ext = ".md"
-- local temp1 = {}
-- temp1[".md"] = "markdown"
-- gs("vimwiki_ext2syntax", temp1)
-- g.vimwiki_list = g.mywiki
g.vimwiki_table_mappings = 0
g.wiki = {
  path = "wiki",
  nested_syntaxes = {
    python = "python",
    cpp = "cpp",
    javascript = "javascript",
    bash = "sh",
    php = "php",
    lua = "lua"
  }
}
g.vimwiki_listsyms = "✗○◐●✓"
g.vimwiki_key_mappings = {
  all_maps = 1,
  links = 1,
  global = 0,
  headers = 0,
  text_objs = 0,
  table_format = 0,
  table_mappings = 0,
  lists = 0,
  html = 0,
  mouse = 0
}

g.tmux_navigator_disable_when_zoomed = 1

-- autopairs

g.AutoPairsUseInsertedCount = 0
g.AutoPairsMultilineClose = 1
g.AutoPairsFlyMode = 0
g.AutoPairsShortcutFastWrap = "<C-e>"
g.AutoPairsShortcutBackInsert = "<C-b>"

-- ale

g.ale_echo_msg_error_str = "E"
g.ale_echo_msg_format = [[(%code%): %s]]
g.ale_echo_msg_warning_str = "W"
g.ale_lint_on_enter = 0
g.ale_lint_on_leave = 0
g.ale_lint_on_insert_leave = 0
g.ale_lint_on_save = 1
g.ale_lint_on_text_changed = "never"
g.ale_sign_error = "•"
g.ale_sign_warning = "•"
g.ale_sign_offset = 1000000
g.ale_virtualtext_cursor = 0
g.ale_warn_about_trailing_blank_lines = 0
g.ale_warn_about_trailing_whitespace = 0
g.ale_lint_on_filetype_changed = 0
g.ale_fixers = vim.empty_dict()
g.ale_lint_delay = 50
g.ale_max_signs = 50
g.ale_maximun_file_size = 800000
g.ale_python_pylint_options = "-j 8"
g.ale_fix_on_save = 0
g.ale_linters = {
  python = {"pylint"},
  yaml = {"yamllint"}
}
g.ale_linters_explicit = 1

g.asmsyntax = "nasm"

-- markdown

g.markdown_fenced_languages = {
  "html",
  "python",
  "sh",
  "nasm",
  "vim",
  "php",
  "javascript",
  "typescript",
  "lua",
  "sql"
}
g.markdown_syntax_conceal = 0
g.vim_markdown_folding_disabled = 1

g.buftabline_show = 0

-- ultisnips

g.UltiSnipsExpandTrigger = ""
g.UltiSnipsSnippetDirectories = {"~/.config/nvim/UltiSnips", "UltiSnips"}
g.UltiSnipsEditSplit = "horizontal"
g.UltiSnipsUsePythonVersion = 3
g.UltiSnipsJumpForwardTrigger = "<tab>"
g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
-- g.UltiSnipsJumpForwardTrigger = "<C-l>"
-- g.UltiSnipsExpandTrigger = "<C-l>"
-- g.UltiSnipsJumpBackwardTrigger = "<C-j>"

--[[

  Plug 'junegunn/fzf.vim'
  width: float range [0 ~ 1]
  height: float range [0 ~ 1]
  Optional
  yoffset: float default 0.5 range [0 ~ 1]
  xoffset: float default 0.5 range [0 ~ 1]
  highlight: [string]: Highlight group for border
  border: [string default rounded]: Border style
  Avaliable Border Style -> rounded: / sharp / horizontal / vertical / top / bottom / left / right

--]]
g.fzf_history_dir = "~/.tmp/fzf-history"
g.fzf_buffers_jump = 1
g.fzf_commits_log_options = [[--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"]]
g.fzf_nvim_statusline = 1

local fzf_colors_tbl = {}
fzf_colors_tbl.fg = {"fg", "Comment"}
fzf_colors_tbl.hl = {"fg", "RedBold"}
fzf_colors_tbl["fg+"] = {"fg", "GreenBold"}
fzf_colors_tbl["bg+"] = {"bg", "fzf_bg_plus"}
fzf_colors_tbl["hl+"] = {"fg", "PurpleBold"}
fzf_colors_tbl.info = {"fg", "fzf_info"}
fzf_colors_tbl.prompt = {"fg", "BlueBold"}
fzf_colors_tbl.pointer = {"fg", "RedBold"}
fzf_colors_tbl.gutter = {"fg", "fzf_bg"}
fzf_colors_tbl.spinner = {"fg", "fzf_spinner"}
g.fzf_colors = fzf_colors_tbl

local clip_copy, clip_paste = "pbcopy", "pbpaste"

if vim.fn.has("macunix") ~= 1 then
  clip_copy = "xclip -sel clip -i"
  clip_paste = "xclip -out -selection clipboard"
end

local clipboard_tbl = {}
clipboard_tbl.name = "limaClipboard"
clipboard_tbl.cache_enabled = 1
clipboard_tbl.copy = {}
clipboard_tbl.copy["*"] = "tmux load-buffer -"
clipboard_tbl.copy["+"] = clip_copy
clipboard_tbl.paste = {}
clipboard_tbl.paste["*"] = "tmux save-buffer -"
clipboard_tbl.paste["+"] = clip_paste
g.clipboard = clipboard_tbl
vim.o.clipboard = "unnamed,unnamedplus"

-- miniyank

g.miniyank_maxitems = 10

-- nvimtree

g.nvim_tree_width = 25
g.nvim_tree_auto_open = 0
g.nvim_tree_auto_close = 1
g.nvim_tree_ignore = {".git", "node_modules", ".cache"}
g.nvim_tree_quit_on_open = 1
g.nvim_tree_follow = 1
g.nvim_tree_width_allow_resize = 1
g.nvim_tree_git_hl = 1
g.nvim_tree_hide_dotfiles = 1
g.nvim_tree_tab_open = 0
g.nvim_tree_disable_netrw = 0
g.nvim_tree_hijack_netrw = 1
g.nvim_tree_add_trailing = 1

-- git-blame

g.gitblame_enabled = 0
g.gitblame_date_format = [[%m/%d/%Y]]
g.gitblame_message_template = [[<author> • <date> • <summary> • <sha>]]
