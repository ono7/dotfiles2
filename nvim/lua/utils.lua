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

return M
