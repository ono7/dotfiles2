-- utilities

function _G.pre_format()
  -- :lua pre_format()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.bo.expandtab = true
  vim.cmd([[%retab!]])
  vim.cmd([[%s/\s\+$//e]])
  vim.cmd([[Format]])
  vim.api.nvim_win_set_cursor(0, pos)
end
