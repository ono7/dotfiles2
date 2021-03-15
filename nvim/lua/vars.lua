local gs = vim.api.nvim_set_var

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

-- -- " use all the beautiful things jedi-vim offers, but leave completion to coc
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
gs("ale_fixers", {})
gs("ale_fix_on_save", 0)
gs("ale_linters", {})
gs("ale_linters_explicit", 1)

gs("asmsyntax", "nasm")

gs(
  "markdown_fenced_languages",
  {
    "html",
    "python",
    "bash,sh",
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

--- API
-- [[ --
-- Global variables (g:):
--   vim.api.nvim_set_var()
--   vim.api.nvim_get_var()
--   vim.api.nvim_del_var()
-- Buffer variables (b:):
--   vim.api.nvim_buf_set_var()
--   vim.api.nvim_buf_get_var()
--   vim.api.nvim_buf_del_var()
-- Window variables (w:):
--   vim.api.nvim_win_set_var()
--   vim.api.nvim_win_get_var()
--   vim.api.nvim_win_del_var()
-- Tabpage variables (t:):
--   vim.api.nvim_tabpage_set_var()
--   vim.api.nvim_tabpage_get_var()
--   vim.api.nvim_tabpage_del_var()
-- Predefined Vim variables (v:):
--   vim.api.nvim_set_vvar()
--   vim.api.nvim_get_vvar()
-- -- ]]
