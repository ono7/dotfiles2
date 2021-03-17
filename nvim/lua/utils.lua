-- utils.lua
local M = {}

M.home = os.getenv("HOME")

function M.create_dir(dst_dir)
  -- ensure dst_dir exists
  assert(type(dst_dir) == "string")
  local data_dir = M.home .. dst_dir
  if not exists(data_dir) then
    os.execute("mkdir" .. data_dir)
  end
end

-- escape expressions to vim e.g. <C-t>
-- useful for creating maps that require expr
function M.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

return M
