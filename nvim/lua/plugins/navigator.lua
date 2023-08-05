local opt = {noremap = true, silent = true}
local m = vim.api.nvim_set_keymap

local status_ok, configs = pcall(require, "Navigator")

if not status_ok then
  print("navigator not loaded - plugins/navigator.lua")
  return
end

configs.setup(
  {
    disable_on_zoom = true
  }
)

m("n", "<C-h>", "<CMD>lua require('Navigator').left()<CR>", opt)
m("n", "<C-k>", "<CMD>lua require('Navigator').up()<CR>", opt)
m("n", "<C-l>", "<CMD>lua require('Navigator').right()<CR>", opt)
m("n", "<C-j>", "<CMD>lua require('Navigator').down()<CR>", opt)
