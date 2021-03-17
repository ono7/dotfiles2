local gs = vim.api.nvim_set_var
local g = vim.g

gs(
  "coc_global_extensions",
  {
    "coc-python",
    "coc-json",
    "coc-tsserver",
    "coc-prettier",
    "coc-omnisharp",
    "coc-lua",
    "coc-yaml"
  }
)
gs("tmux_navigator_disable_when_zoomed", 1)

-- " use all the beautiful things jedi-vim offers, but leave completion to coc
gs("jedi#completions_enabled", 0)
gs("jedi#goto_assignments_command", "")

gs("AutoPairsUseInsertedCount", 0)
gs("AutoPairsFlyMode", 0)
gs("AutoPairsShortcutFastWrap", "<C-e>")
gs("AutoPairsShortcutBackInsert", "<C-b>")

gs("vimwiki_global_ext", 0)
gs("vimwiki_table_mappings", 0)
gs(
  "wiki",
  {
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
)

gs("vimwiki_listsyms", "✗○◐●✓")
gs("vim_markdown_folding_disabled", 1)

gs("ale_echo_msg_error_str", "E")
gs("ale_echo_msg_format", "(%code%): %s")
gs("ale_echo_msg_warning_str", "W")
gs("ale_lint_on_enter", 1)
gs("ale_lint_on_save", 1)
gs("ale_lint_on_text_changed", "always")

gs("ale_sign_error", "•")
gs("ale_sign_warning", "•")
gs("ale_sign_offset", 1000000)
gs("ale_virtualtext_cursor", 0)
gs("ale_warn_about_trailing_blank_lines", 0)
gs("ale_warn_about_trailing_whitespace", 0)
gs("ale_lint_on_filetype_changed", 0)
gs("ale_fixers", vim.empty_dict())
gs("ale_fix_on_save", 0)
gs("ale_linters", vim.empty_dict())
gs("ale_linters_explicit", 1)

gs("asmsyntax", "nasm")

gs(
  "markdown_fenced_languages",
  {
    "html",
    "python",
    "sh",
    "nasm",
    "vim",
    "php",
    "javascript",
    "lua",
    "sql"
  }
)
gs("markdown_syntax_conceal", 0)

gs("buftabline_show", 0)
gs("SuperTabDefaultCompletionType", "<C-n>")
gs("SuperTabClosePreviewOnPopupClose", 1)

gs("UltiSnipsExpandTrigger", "<tab>")
gs("UltiSnipsJumpForwardTrigger", "<tab>")
gs("UltiSnipsJumpBackwardTrigger", "<s-tab>")
gs("UltiSnipsSnippetDirectories", {"~/.config/nvim/UltiSnips", "UltiSnips"})
gs("UltiSnipsEditSplit", "horizontal")
gs("UltiSnipsUsePythonVersion", 3)

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
local fzf_window_tbl = {
  window = {
    width = 1,
    height = 1,
    highlight = "Comment",
    border = "bottom"
  }
}

-- gs("fzf_layout", fzf_window_tbl)
gs("fzf_history_dir", "~/.tmp/fzf-history")
gs("fzf_buffers_jump", 1)
gs("fzf_commits_log_options", '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"')
gs("fzf_nvim_statusline", 1)

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

gs("fzf_colors", fzf_colors_tbl)

gs("indentLine_char", "‧")
gs("indentLine_color_term", 8)
gs("indentLine_concealcursor", "inc")
gs("indentLine_conceallevel", 2)
gs(
  "indentLine_fileTypeExclude",
  {
    "text",
    "markdown"
  }
)
gs("indentLine_enabled", 0)

local clip_copy, clip_paste = "pbcopy", "pbpaste"

-- TODO: 03-15-2021 | this does not work
if vim.api.nvim_eval('has("macunix")') ~= 1 then
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

gs("clipboard", clipboard_tbl)

vim.o.clipboard = "unnamed,unnamedplus"

-- miniyank
g.miniyank_maxitems = 10

-- nvimtree
g.nvim_tree_width = 25
g.nvim_tree_auto_open = 1
g.nvim_tree_auto_close = 1
-- gs("nvim_tree_ignore", {".git", "node_modules", ".cache"})
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

--[[

  vim API
  Global variables (g:):
    vim.api.nvim_set_var()
    vim.api.nvim_get_var()
    vim.api.nvim_del_var()
  Buffer variables (b:):
    vim.api.nvim_buf_set_var()
    vim.api.nvim_buf_get_var()
    vim.api.nvim_buf_del_var()
  Window variables (w:):
    vim.api.nvim_win_set_var()
    vim.api.nvim_win_get_var()
    vim.api.nvim_win_del_var()
  Tabpage variables (t:):
    vim.api.nvim_tabpage_set_var()
    vim.api.nvim_tabpage_get_var()
    vim.api.nvim_tabpage_del_var()
  Predefined Vim variables (v:):
    vim.api.nvim_set_vvar()
    vim.api.nvim_get_vvar()

--]]
--
