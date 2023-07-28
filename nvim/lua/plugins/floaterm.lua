local status_ok, Fterm = pcall(require, "Fterm")

if not status_ok then
  print("Fterm not loaded - plugins/Fterm.lua")
  return
end

vim.keymap.set("n", "<c-t>", '<CMD>lua require("FTerm").toggle()<CR>', { noremap = true, silent = true })
-- vim.keymap.set("n", "<c-t>", '<CMD>lua require("FTerm").run({ "cd", "%:p:h" })<CR>', { noremap = true, silent = true })
vim.keymap.set("t", "<c-t>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', { noremap = true, silent = true })
