-- utilities

function _G.resetTab()
  -- retab file, :lua v:retab()
  vim.bo.expandtab = true
  vim.api.nvim_command([[:retab<cr>]])
end
