local gs, g = vim.api.nvim_set_var, vim.g

--- nvim-completion ---
g.completion_sorting = "length"

--- lsp ---
g.completion_matching_strategy_list = {"exact", "substring", "fuzzy"}

g.tmux_navigator_disable_when_zoomed = 1

-- --- autopairs ---
-- g.AutoPairsMapCR = 0
-- g.AutoPairsUseInsertedCount = 0
-- g.AutoPairsMultilineClose = 1
-- g.AutoPairsFlyMode = 0
-- g.AutoPairsShortcutFastWrap = "<C-g>"
-- g.AutoPairsShortcutBackInsert = "<C-b>"

--- ale ---
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
g.ale_lint_delay = 25
g.ale_max_signs = 50
g.ale_maximun_file_size = 800000
g.ale_python_pylint_options = "-j 8"
g.ale_lua_luacheck_options = "--globals vim love M --allow-defined"
g.ale_fix_on_save = 0
g.ale_linters = {
  python = {"pylint"},
  yaml = {"yamllint"},
  lua = {"luacheck"},
  json = {"jsonlint"}
}
g.ale_linters_explicit = 1

--- handle assembly language syntax ---
g.asmsyntax = "nasm"

--- markdown ---
g.markdown_fenced_languages = {
  "html",
  "python",
  "sh",
  "nasm",
  "vim",
  "php",
  "javascript",
  "java",
  "typescript",
  "lua",
  "sql",
  "yaml",
  "json"
}
g.markdown_syntax_conceal = 2
g.vim_markdown_folding_disabled = 1
g.markdown_folding = 0
g.buftabline_show = 0

--- fix python indentation
g.pyindent_continue = "&sw"
g.pyindent_open_paren = "0"
g.pyindent_nested_paren = "&sw"

--- ultisnips ---
-- g.UltiSnipsExpandTrigger = "<c-l>"
-- g.UltiSnipsSnippetDirectories = {"~/.config/nvim/UltiSnips", "UltiSnips"}
-- g.UltiSnipsEditSplit = "horizontal"
-- g.UltiSnipsUsePythonVersion = 3
-- g.UltiSnipsJumpForwardTrigger = "<c-l>"
-- g.UltiSnipsJumpBackwardTrigger = ""

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
-- g.fzf_history_dir = "~/.tmp/fzf-history"
g.fzf_layout = {window = {width = 0.9, height = 0.8, border = "sharp"}}
g.fzf_buffers_jump = 1
g.fzf_commits_log_options = [[--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"]]
g.fzf_nvim_statusline = 1
g.fzf_preview = {
  -- arguments to the FZF '--preview-window' option
  "right:+{2}-/2" -- preview on the right and centered on entry
}
g.fzf_action = {
  ["ctrl-x"] = "tabedit",
  ["ctrl-v"] = "vsplit",
  ["ctrl-t"] = "split"
}
g.fzf_modifier = ":~:." -- format FZF entries, see |filename-modifiers|
g.fzf_trim = true -- trim FZF entries

local fzf_colors_tbl = {}
fzf_colors_tbl.fg = {"fg", "Comment"}
fzf_colors_tbl.bg = {"bg", "Normal"}
fzf_colors_tbl.hl = {"fg", "String"}
fzf_colors_tbl["fg+"] = {"fg", "FZFfgPlus"}
fzf_colors_tbl["bg+"] = {"bg", "Visual"} -- gutter bg
fzf_colors_tbl["hl+"] = {"fg", "myRed"}
fzf_colors_tbl.info = {"fg", "fzf_info"}
fzf_colors_tbl.prompt = {"fg", "myBlue"}
fzf_colors_tbl.gutter = {"fg", "FZFgutter"}
fzf_colors_tbl.pointer = {"fg", "myRed"}
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

--- miniyank ---
g.miniyank_maxitems = 10

--- nvimtree ---
g.nvim_tree_width = 25
g.nvim_tree_auto_open = 0 -- open on vim start
g.nvim_tree_auto_close = 0 -- close vim if ntree is last buffer
g.nvim_tree_ignore = {".git", "node_modules", ".cache", "__pycache__"}
g.nvim_tree_quit_on_open = 0
g.nvim_tree_follow = 1
g.nvim_tree_width_allow_resize = 1
g.nvim_tree_highlight_opened_files = 1
g.nvim_tree_git_hl = 1
g.nvim_tree_hide_dotfiles = 1
g.nvim_tree_tab_open = 0
g.nvim_tree_hijack_netrw = 1
g.nvim_tree_disable_netrw = 1
g.nvim_tree_add_trailing = 1
g.nvim_tree_indent_markers = 1
g.nvim_tree_show_icons = {git = 1, folder = 1, files = 1, folder_arrows = 0}
g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "",
    staged = "✓",
    unmerged = "",
    renamed = "",
    untracked = "",
    deleted = "",
    ignored = ""
  },
  folder = {
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
    symlink_open = ""
  },
  lsp = {
    hint = "",
    info = "",
    warning = "",
    error = ""
  }
}

--- git-blame ---
g.gitblame_enabled = 0
g.gitblame_date_format = [[%m/%d/%Y]]
g.gitblame_message_template = [[<author> • <date> • <summary> • <sha>]]
