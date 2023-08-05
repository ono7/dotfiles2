local gs, g = vim.api.nvim_set_var, vim.g

--- nvim-completion ---
g.completion_sorting = "length"

--- lsp ---
g.completion_matching_strategy_list = {"exact", "substring", "fuzzy"}

g.tmux_navigator_disable_when_zoomed = 1

--- handle assembly language syntax ---
g.asmsyntax = "nasm"

g.java_ignore_javadoc = 1

--- markdown ---
g.markdown_fenced_languages = {
  "html",
  "python",
  "sh",
  "bash=sh",
  "nasm",
  "vim",
  "php",
  "javascript",
  "typescript",
  "lua",
  "terraform=tf",
  "sql",
  "yaml",
  "json",
  "go"
}

-- g.markdown_syntax_conceal = 2
g.vim_markdown_folding_disabled = 1

g.markdown_folding = 0
g.buftabline_show = 0

--- fix python indentation
g.pyindent_continue = "&sw"
g.pyindent_open_paren = "0"
g.pyindent_nested_paren = "&sw"

--- miniyank ---
g.miniyank_maxitems = 10

--- git-blame ---
g.gitblame_enabled = 0
g.gitblame_date_format = [[%m/%d/%Y]]
g.gitblame_message_template = [[<author> • <date> • <summary> • <sha>]]

