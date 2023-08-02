local status_ok, configs = pcall(require, "nvim-treesitter.configs")

if not status_ok then
  vim.cmd [[syntax on]]
  print("problem loading treesitter - plugins/treesitter.lua, enabled classic syntax on")
  return
end

configs.setup {
  sync_install = false,
  auto_install = true,
  indent = { enable = false, disable = { "python" } },
  highlight = {
    max_file_lines = 10000,
    enable = true,
    additional_vim_regex_highlighting = false,
    indent = { enable = false },
    incremental_selection = { enable = false },
    textobjects = { enable = false },
    rainbow = {
      max_file_lines = 5000,
    },
    disable = function(lang, buf)
      local max_filesize = 500 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        print("max stats.size > 500KB lua, check max size in plugins/treesitter.lua")
        return true
      end
    end,
  },
  ensure_installed = {
    "bash",
    "comment",
    "go",
    "html",
    "css",
    "javascript",
    "json",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "python",
    "regex",
    "terraform",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
  },
  context_commentstring = {
    enable = true,
  },
}
