# neovim api

# `_G`

```lua
function _G.better_insert()
  -- _G global lua obj exposed via v:lua in vim
  -- "_ddO -> "_ preserves the register
  -- local col = vim.fn.col(".") - 1
  local line = vim.api.nvim_get_current_line()
  if #line == 0 then
    return '"_ddO'
  else
    return "i"
  end
end
```
