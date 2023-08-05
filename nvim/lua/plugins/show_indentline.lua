local ok, config = pcall(require, "indent_blankline")

if not ok then
  print("indent_blankline not loaded")
  return
end

config.setup {
  -- show_current_context = true,
  -- show_current_context_start = true,
  space_char_blankline = " ",
}

local ts_ok, ts_config = pcall(require, "treesitter_indent_object")

if not ts_ok then
  print("treesitter_indent_object not loaded")
  return
end

ts_config.setup()
-- select context-aware indent
vim.keymap.set({ "x", "o" }, "ai", "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer()<CR>")
-- ensure selecting entire line (or just use Vai)
vim.keymap.set({ "x", "o" }, "aI", "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer(true)<CR>")
-- select inner block (only if block, only else block, etc.)
vim.keymap.set({ "x", "o" }, "ii", "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner()<CR>")
-- select entire inner range (including if, else, etc.)
vim.keymap.set({ "x", "o" }, "iI", "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner(true)<CR>")
