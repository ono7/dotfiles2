function _G.legacy()
  -- :lua legacy()
  vim.api.nvim_paste(require("my.extra_vars").legacy_cfg, true, -1)
end

function _G.legacy_min()
  -- :lua legacy()
  vim.api.nvim_paste(require("my.extra_vars").legacy_min, true, -1)
end

function _G.perflog()
  vim.cmd([[profile start ~/profile.log]])
  vim.cmd([[profile func *]])
  vim.cmd([[profile file *]])
end
