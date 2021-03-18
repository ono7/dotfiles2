-- utilities

function _G.pre_format()
  -- retab file, :lua v:retab()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.bo.expandtab = true
  vim.api.nvim_command([[:%s/\s\+$//e | retab<cr>]])
  vim.api.nvim_win_set_cursor(0, pos)
end
