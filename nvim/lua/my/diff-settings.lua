local m = vim.api.nvim_set_keymap
local opt = { noremap = true }

if vim.opt.diff:get() then
  vim.wo.signcolumn = "no"
  vim.wo.foldcolumn = "0"
  vim.wo.numberwidth = 1
  vim.wo.number = true
  vim.o.cmdheight = 2
  vim.o.diffopt = "filler,context:0,internal,algorithm:histogram,indent-heuristic"
  vim.o.laststatus = 3
  m("n", "]", "]c", opt)
  m("n", "[", "[c", opt)
end
