M = {}

M.highlight = function(group, options)
  local guifg = options.fg or "NONE"
  local guibg = options.bg or "NONE"
  local gui = options.gui or "NONE"
  local guisp = options.guisp or "NONE"

  vim.cmd(string.format("highlight! %s guifg=%s guibg=%s gui=%s guisp=%s", group, guifg, guibg, gui, guisp))
end

M.link = function(groupa, groupb)
  vim.cmd(string.format("highlight! link %s %s", groupa, groupb))
end

M.clear = function(grp)
  vim.cmd(string.format("silent! syn clear  %s", grp))
end

M.colors = {
  red = "#ee737c",
  dark_red = "#BE5046",
  visual = "#204062",
  -- green = "#98C379",
  -- green = "#98c379",
  diff_green = "#7ca960",
  diff_red = "#864046",
  diff_yellow = "#3a3f4d",
  yellow = "#e5c07b",
  dark_yellow = "#e5c07b",
  -- blue = "#499dd7",
  -- orange = "#e78a4e",
  purple = "#C678DD",
  -- cyan = "#56B6C2",
  -- white = "#c2c6cc",
  current_bg = "#1e222a",
  black = "#23272e",
  itermbg = "#282c34",
  dimm_black = "#1c1c1c",
  dark_black = "#1a1a1a",
  comment_grey = "#5f6673",
  -- light_grey = "#939eb3",
  gutter_fg_grey = "#4B5263",
  cursor_grey = "#2C323C",
  visual_grey = "#3E4452",
  special_grey = "#3B4048",
  bracket_grey = "#7C828C",
  ------ new colors to play with -----
  white = "#abb2bf",
  darker_black = "#1b1f27",
  -- black = "#1e222a", --  nvim bg
  black2 = "#252931",
  one_bg = "#282c34", -- real bg of onedark
  one_bg2 = "#353b45",
  one_bg3 = "#30343c",
  grey = "#42464e",
  grey_fg = "#565c64",
  grey_fg2 = "#6f737b",
  light_grey = "#6f737b",
  -- red = "#d47d85",
  baby_pink = "#DE8C92",
  pink = "#ff75a0",
  line = "#2a2e36", -- for lines like vertsplit
  green = "#A3BE8C",
  vibrant_green = "#7eca9c",
  nord_blue = "#81A1C1",
  blue = "#61afef",
  -- yellow = "#e7c787",
  sun = "#EBCB8B",
  -- purple = "#b4bbc8",
  dark_purple = "#c882e7",
  teal = "#519ABA",
  -- orange = "#fca2aa",
  orange = "#f08017",
  cyan = "#a3b8ef",
  statusline_bg = "#22262e",
  lightbg = "#2d3139",
  lightbg2 = "#262a32"
}

M.setup = function()
  vim.g.colors_name = "onedark"
  vim.cmd [[set background=dark]]
  vim.cmd [[highlight clear]]
  vim.cmd [[syntax reset]]

  M.highlight("MsgArea", {fg = M.colors.light_grey})
  M.highlight("MsgSeparator", {})
  M.highlight("EndOfBuffer", {fg = M.colors.current_bg}) -- hide eob markers
  M.highlight("Comment", {fg = M.colors.comment_grey, gui = "italic"})
  M.highlight("Constant", {fg = M.colors.cyan, gui = "bold"})
  M.highlight("String", {fg = M.colors.green})
  M.highlight("Character", {fg = M.colors.green})
  M.highlight("Number", {fg = M.colors.yellow})
  M.highlight("Boolean", {fg = M.colors.white, gui = "italic,bold"})
  M.highlight("Float", {fg = M.colors.dark_yellow})
  M.highlight("Identifier", {fg = M.colors.red})
  M.highlight("Function", {fg = M.colors.white})
  M.highlight("Statement", {fg = M.colors.purple, gui = "italic"})
  M.highlight("Conditional", {fg = M.colors.purple, gui = "italic"})
  M.highlight("Repeat", {fg = M.colors.yellow, gui = "italic"})
  M.highlight("Label", {fg = M.colors.purple})
  M.highlight("Operator", {fg = M.colors.yellow, gui = "italic"})
  M.highlight("Keyword", {fg = M.colors.red, gui = "italic"})
  M.highlight("Exception", {fg = M.colors.red, gui = "italic"})
  M.highlight("PreProc", {fg = M.colors.yellow})
  M.highlight("Include", {fg = M.colors.blue, gui = "italic"})
  M.highlight("Define", {fg = M.colors.purple, gui = "italic"})
  M.highlight("Macro", {fg = M.colors.purple})
  M.highlight("PreCondit", {fg = M.colors.yellow})
  M.highlight("Type", {fg = M.colors.yellow})
  M.highlight("StorageClass", {fg = M.colors.yellow})
  M.highlight("Structure", {fg = M.colors.yellow})
  M.highlight("Typedef", {fg = M.colors.yellow})
  M.highlight("Special", {fg = M.colors.blue, gui = "italic"})
  M.highlight("SpecialChar", {})
  M.highlight("Tag", {})
  M.highlight("Delimiter", {})
  M.highlight("SpecialComment", {fg = M.colors.light_grey, gui = "italic"})
  M.highlight("Debug", {})
  M.highlight("Underlined", {gui = "underline"})
  M.highlight("Bold", {gui = "bold"})
  M.highlight("CursorWord0", {gui = "bold"})
  M.highlight("CursorWord1", {gui = "bold"})
  M.highlight("Ignore", {})
  M.highlight("Error", {fg = M.colors.light_grey, gui = "bold"})
  M.highlight("Todo", {fg = M.colors.red, gui = "italic,bold"})
  M.highlight("ColorColumn", {bg = M.colors.dark_black})
  M.highlight("Conceal", {})
  M.highlight("CursorIM", {})
  M.highlight("CursorColumn", {bg = M.colors.dark_black})
  M.highlight("CursorLine", {bg = M.colors.dark_black})
  M.highlight("Directory", {fg = M.colors.cyan})
  M.highlight("DiffAdd", {bg = M.colors.diff_green, fg = M.colors.black})
  M.highlight("DiffChange", {})
  M.highlight("DiffDelete", {fg = M.colors.light_grey})
  M.highlight("DiffText", {bg = M.colors.diff_yellow})
  -- M.highlight("DiffChange", {bg = M.colors.blue, fg = M.colors.black})
  -- M.highlight("DiffDelete", {bg = M.colors.red, fg = M.colors.black})
  M.highlight("ErrorMsg", {fg = M.colors.light_grey, gui = "bold"})
  M.highlight("VertSplit", {fg = M.colors.comment_grey})
  M.highlight("Folded", {fg = M.colors.comment_grey, gui = "italic,bold"})
  M.highlight("FoldColumn", {})
  M.highlight("SignColumn", {})
  M.highlight("IncSearch", {bg = M.colors.visual})
  M.highlight("LineNr", {fg = M.colors.gutter_fg_grey})
  M.highlight("CursorLineNr", {fg = M.colors.green})
  M.highlight("MatchParen", {fg = M.colors.white, bg = M.colors.visual_grey, gui = "bold,underline"})
  M.highlight("ModeMsg", {gui = "italic"})
  M.highlight("MoreMsg", {fg = M.colors.white, gui = "italic"})
  M.highlight("NonText", {fg = M.colors.blue})
  -- M.highlight("NonText", {fg = M.colors.special_grey})
  M.highlight("Normal", {fg = M.colors.white})
  M.highlight("Pmenu", {bg = M.colors.visual_grey})
  M.highlight("PmenuSel", {bg = M.colors.special_grey, gui = "reverse"})
  M.highlight("PmenuSbar", {bg = M.colors.special_grey})
  M.highlight("PmenuThumb", {bg = M.colors.white})
  M.highlight("Question", {fg = M.colors.light_grey, gui = "bold,italic"})
  M.highlight("Search", {bg = M.colors.visual})
  M.highlight("ESearchMatch", {fg = M.colors.black, bg = M.colors.light_grey})
  M.highlight("QuickFixLine", {bg = M.colors.special_grey, gui = "bold"})
  M.highlight("qfFileName", {fg = M.colors.yellow, gui = "bold"})
  M.highlight("qfLineNr", {fg = M.colors.blue})
  M.highlight("SpecialKey", {fg = M.colors.orange})
  M.highlight("SpellBad", {guisp = M.colors.red, gui = "underline,undercurl"})
  M.highlight("SpellCap", {guisp = M.colors.yellow, gui = "underline,undercurl"})
  M.highlight("SpellLocal", {gui = "underline"})
  M.highlight("SpellRare", {gui = "underline"})
  -- M.highlight("StatusLine", {fg = M.colors.white, bg = M.colors.visual_grey})
  M.highlight("StatusLineNC", {fg = M.colors.comment_grey, gui = "underline"})
  M.highlight("StatusLine", {fg = M.colors.white, gui = "underline"})
  M.highlight("TabLine", {fg = M.colors.comment_grey})
  M.highlight("TabLineFill", {})
  M.highlight("TabLineSel", {fg = M.colors.white})
  M.highlight("Title", {fg = M.colors.green})
  M.highlight("Visual", {fg = M.colors.visual_black, bg = M.colors.visual})
  M.highlight("VisualNOS", {bg = M.colors.visual_grey})
  M.highlight("WarningMsg", {fg = M.colors.yellow})
  M.highlight("WildMenu", {fg = M.colors.black, bg = M.colors.blue})
  M.highlight("WinNormalNC", {bg = M.colors.dark_black})
  M.highlight("HighlightedyankRegion", {bg = M.colors.light_grey})

  --- Languages ---

  -- Markdown
  M.highlight("markdownCode", {fg = M.colors.yellow})
  M.highlight("markdownCodeBlockBG", {bg = M.colors.dimm_black})
  M.highlight("markdownCodeBlockBGBorder", {bg = M.colors.dark_black})
  M.highlight("markdownCodeBlockBGBorderSign", {fg = M.colors.gutter_fg_grey})
  M.highlight("markdownCodeBlock", {fg = M.colors.yellow})
  M.highlight("markdownCodeDelimiter", {fg = M.colors.comment_grey})
  M.highlight("markdownHeadline", {bg = M.colors.cursor_grey})
  M.highlight("markdownFirstHeadline", {bg = M.colors.diff_green})
  M.highlight("markdownSecondHeadline", {bg = M.colors.diff_yellow})
  M.highlight("markdownHeadingDelimiter", {fg = M.colors.gutter_fg_grey})
  M.highlight("markdownRule", {fg = M.colors.comment_grey})
  M.highlight("markdownHeadingRule", {fg = M.colors.comment_grey})
  M.highlight("markdownH1", {fg = M.colors.green, gui = "bold,italic"})
  M.highlight("markdownH2", {fg = M.colors.blue, gui = "bold,italic"})
  M.highlight("markdownH3", {fg = M.colors.cyan, gui = "bold,italic"})
  M.highlight("markdownH4", {fg = M.colors.red, gui = "bold,italic"})
  M.highlight("markdownH5", {fg = M.colors.orange, gui = "bold,italic"})
  M.highlight("markdownH6", {fg = M.colors.green, gui = "bold,italic"})
  M.highlight("markdownIdDelimiter", {fg = M.colors.purple})
  M.highlight("markdownId", {fg = M.colors.purple})
  M.highlight("markdownBlockquote", {fg = M.colors.comment_grey})
  M.highlight("markdownItalic", {gui = "italic"})
  M.highlight("markdownBold", {fg = M.colors.white, gui = "bold"})
  M.highlight("markdownListMarker", {fg = M.colors.red})
  M.highlight("markdownOrderedListMarker", {fg = M.colors.red})
  M.highlight("markdownIdDeclaration", {fg = M.colors.blue})
  M.highlight("markdownLinkText", {fg = M.colors.blue})
  M.highlight("markdownLinkDelimiter", {fg = M.colors.white})
  M.highlight("markdownUrl", {fg = M.colors.purple})

  --- Treesitter ---
  -- Misc
  M.highlight("TSError", {fg = M.colors.cyan})
  -- M.highlight("TSPunctDelimiter", {fg = M.colors.white, gui = "bold"})
  M.highlight("TSPunctDelimiter", {fg = M.colors.white, gui = "bold"})
  M.highlight("TSPunctBracket", {fg = M.colors.blue})
  M.highlight("TSPunctSpecial", {fg = M.colors.yellow})

  --- Constants ---
  -- -- M.highlight("TSConstant", {})
  M.highlight("TSConstBuiltin", {fg = M.colors.yellow})
  -- -- Not sure about this guy
  -- M.highlight("TSConstMacro", {})
  M.highlight("TSString", {})
  -- M.highlight("TSStringRegex", {})
  M.highlight("TSStringEscape", {fg = M.colors.yellow})
  -- M.highlight("TSCharacter", {})
  M.highlight("TSNumber", {fg = M.colors.yellow})
  M.highlight("TSBoolean", {fg = M.colors.white, gui = "italic,bold"})
  M.highlight("TSFloat", {fg = M.colors.yellow})
  -- M.highlight("TSAnnotation", {})
  -- M.highlight("TSAttribute", {})
  -- M.highlight("TSNamespace", {})

  --- Functions ---
  M.highlight("TSFuncBuiltin", {fg = M.colors.white})
  M.highlight("TSFunction", {fg = M.colors.white, gui = "italic"})
  -- M.highlight("TSFuncMacro", {})
  M.highlight("TSParameter", {fg = M.colors.white})
  -- M.highlight("TSParameterReference", {})
  M.highlight("TSMethod", {fg = M.colors.white})
  M.highlight("TSField", {fg = M.colors.white})
  M.highlight("TSProperty", {fg = M.colors.white})
  M.highlight("TSConstructor", {fg = M.colors.red})

  --- Keywords ---
  M.highlight("TSConditional", {fg = M.colors.purple, gui = "italic"})
  M.highlight("TSRepeat", {fg = M.colors.yellow, gui = "italic"})
  -- M.highlight("TSLabel", {})
  M.highlight("TSKeyword", {fg = M.colors.purple, gui = "italic"})
  M.highlight("TSKeywordFunction", {fg = M.colors.purple, gui = "italic"})
  M.highlight("TSKeywordReturn", {fg = M.colors.purple, gui = "italic"})
  M.highlight("TSKeywordOperator", {fg = M.colors.yellow, gui = "italic"})
  M.highlight("TSOperator", {fg = M.colors.cyan, gui = "bold"})
  -- M.highlight("TSException", {})
  M.highlight("TSType", {fg = M.colors.yellow})
  M.highlight("TSTypeBuiltin", {fg = M.colors.yellow})
  -- M.highlight("TSStructure", {})
  M.highlight("TSInclude", {fg = M.colors.cyan, gui = "italic"})

  -- Variable
  M.highlight("TSVariable", {fg = M.colors.white})
  M.highlight("TSVariableBuiltin", {fg = M.colors.white})

  -- -- Text
  -- M.highlight("TSText", {})
  -- M.highlight("TSStrong", {})
  -- M.highlight("TSEmphasis", {})
  -- M.highlight("TSUnderline", {})
  -- M.highlight("TSTitle", {})
  -- M.highlight("TSLiteral", {})
  -- M.highlight("TSURI", {})

  -- -- Tags
  -- M.highlight("TSTag", {})
  -- M.highlight("TSTagDelimiter", {})

  --- Plugins ---
  M.highlight("illuminatedWord", {gui = "bold"})

  M.highlight("diffAdded", {fg = M.colors.green})
  M.highlight("diffRemoved", {fg = M.colors.red})
  M.highlight("gitcommitComment", {fg = M.colors.gutter_fg_grey, gui = "italic"})
  M.highlight("gitcommitUnmerged", {fg = M.colors.green})
  M.highlight("gitcommitOnBranch", {})
  M.highlight("gitcommitBranch", {fg = M.colors.purple})
  M.highlight("gitcommitDiscardedType", {fg = M.colors.red})
  M.highlight("gitcommitSelectedType", {fg = M.colors.green})
  M.highlight("gitcommitHeader", {})
  M.highlight("gitcommitUntrackedFile", {fg = M.colors.cyan})
  M.highlight("gitcommitDiscardedFile", {fg = M.colors.red})
  M.highlight("gitcommitSelectedFile", {fg = M.colors.green})
  M.highlight("gitcommitUnmergedFile", {fg = M.colors.yellow})
  M.highlight("gitcommitFile", {})
  M.highlight("gitcommitSummary", {fg = M.colors.white})
  M.highlight("gitcommitOverflow", {fg = M.colors.red})

  M.highlight("Defx_git_Untracked", {fg = M.colors.red})
  M.link("Defx_git_4_Untracked", "gitcommitUntrackedFile")
  M.link("Defx_git_4_Ignored", "gitcommitSummary")
  M.link("Defx_git_4_Unknown", "gitcommitSummary")
  M.link("Defx_git_4_Renamed", "gitcommitBranch")
  M.link("Defx_git_4_Modified", "gitcommitUnmergedFile")
  M.link("Defx_git_4_Unmerged", "diffRemoved")
  M.link("Defx_git_4_Deleted", "diffRemoved")
  M.link("Defx_git_4_Staged", "diffAdded")

  M.highlight("VimwikiHR", {fg = M.colors.yellow})
  M.highlight("VimwikiPre", {fg = M.colors.cursor_grey})
  M.highlight("VimwikiItalic", {gui = "italic"})
  M.highlight("VimwikiColorTagRed", {fg = M.colors.red})
  M.highlight("VimwikiColorTagCyan", {fg = M.colors.cyan})
  M.highlight("VimwikiColorTagGreen", {fg = M.colors.green})
  M.highlight("VimwikiColorTagBlue", {fg = M.colors.blue})
  M.highlight("VimwikiColorTagPurple", {fg = M.colors.purple})
  M.highlight("VimwikiDate", {fg = M.colors.yellow, gui = "bold"})
  M.highlight("VimwikiHeaderChar", {fg = M.colors.comment_grey})
  M.highlight("VimwikiHeader1", {fg = M.colors.green, gui = "bold"})
  M.highlight("VimwikiHeader2", {fg = M.colors.yellow, gui = "bold"})
  M.highlight("VimwikiHeader3", {fg = M.colors.orange, gui = "bold"})
  M.highlight("VimwikiHeader4", {fg = M.colors.red, gui = "bold"})
  M.highlight("VimwikiHeader5", {fg = M.colors.blue, gui = "bold"})
  M.highlight("VimwikiHeader6", {fg = M.colors.cyan, gui = "bold"})

  M.highlight("IndentGuide", {fg = M.colors.cursor_grey})
  M.highlight("Whitespace", {fg = M.colors.red, gui = "bold"})

  M.link("gwitcommitNoBranch", "gitcommitBranch")
  M.link("gitcommitUntracked", "gitcommitComment")
  M.link("gitcommitDiscarded", "gitcommitComment")
  M.link("gitcommitSelected", "gitcommitComment")
  M.link("gitcommitDiscardedArrow", "gitcommitDiscardedFile")
  M.link("gitcommitSelectedArrow", "gitcommitSelectedFile")
  M.link("gitcommitUnmergedArrow", "gitcommitUnmergedFile")
  M.link("gitmessengerPopupNormal", "WinNormalNC")

  M.highlight("GitGutterAdd", {fg = M.colors.green})
  M.highlight("GitGutterChange", {fg = M.colors.purple})
  M.highlight("GitGutterDelete", {fg = M.colors.red})

  M.highlight("EchoDocFloat", {bg = M.colors.dark_black})

  M.highlight("LspDiagnosticsDefaultError", {fg = M.colors.dark_red, gui = "bold"})
  M.highlight("LspDiagnosticsDefaultWarning", {fg = M.colors.purple, gui = "bold"})
  M.highlight("LspDiagnosticsDefaultInformation", {fg = M.colors.cyan, gui = "bold"})
  M.highlight("LspDiagnosticsDefaultHint", {fg = M.colors.comment_grey, gui = "italic"})
  M.highlight("LspDiagnosticsUnderlineError", {fg = M.colors.dark_red, gui = "underline"})
  M.highlight("LspDiagnosticsUnderlineWarning", {fg = M.colors.purple, gui = "underline"})
  M.highlight("LspDiagnosticsUnderlineInformation", {fg = M.colors.cyan, gui = "underline"})
  M.highlight("LspDiagnosticsUnderlineHint", {fg = M.colors.comment_grey, gui = "underline"})
  M.highlight("TSDefinitionUsage", {gui = "bold"})
  M.highlight("TSDefinition", {gui = "bold"})

  --- python ---
  M.highlight("pythonBuiltin", {fg = M.colors.blue, gui = "italic"})
  M.highlight("myBold", {gui = "bold"})
  M.highlight("myRed", {fg = M.colors.red, gui = "bold"})
  M.highlight("myYellow", {fg = M.colors.yellow})
  M.highlight("myCyan", {fg = M.colors.cyan})
  M.highlight("myBlue", {fg = M.colors.blue})

  --- ALE ---
  M.highlight("ALEWarningSign", {fg = M.colors.yellow})
  M.highlight("ALEErrorSign", {fg = M.colors.red})
  M.highlight("ALEWarning", {guisp = M.colors.yellow, gui = "underline,bold"})
  M.highlight("ALEError", {guisp = M.colors.red, gui = "underline,bold"})

  --- FZF ---
  M.highlight("FZFgutter", {fg = M.colors.current_bg})
  M.highlight("FZFbgPlus", {bg = M.colors.comment_grey})
  M.highlight("FZFfgPlus", {fg = M.colors.white, gui = "bold"})
  M.highlight("FZFhl", {fg = M.colors.yellow})

  --- snippets ---
  M.clear("snipLeadingSpaces")
  M.highlight("snipLeadingSpaces", {})
end

return M
