local status_ok, surround = pcall(require, "nvim-surround")

if not status_ok then
  print("surround not loaded - plugins/surround.lua")
  return
end

surround.setup(
  {
    keymaps = {
      insert = "<C-g>s",
      insert_line = "<C-g>S",
      normal = "s",
      normal_cur = "ys",
      normal_line = "yS",
      normal_cur_line = "ySS",
      visual = "S",
      visual_line = "gS",
      delete = "ds",
      change = "cs"
    }
  }
)
