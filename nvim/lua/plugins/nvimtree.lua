local g = vim.g
local status_ok, nvim_tree = pcall(require, "nvim-tree")

if not status_ok then
  print("nvim-tree not loaded correctly")
  return
end

g.loaded = 1
g.loaded_netrwPlugin = 1

vim.cmd([[hi! NvimTreeIndentMarker guifg=#3fc5ff]])

nvim_tree.setup({
  view = {
    adaptive_size = false,
    width = 25,
    -- height = 30,
    hide_root_folder = false,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {},
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
    ignore = false,
    show_on_dirs = true,
    timeout = 400,
  },
  renderer = {
    highlight_opened_files = "none",
    indent_markers = {
      enable = true,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
})
