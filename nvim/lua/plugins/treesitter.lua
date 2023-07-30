local status_ok, configs = pcall(require, "nvim-treesitter.configs")

if not status_ok then
  print("problem loading treesitter - plugins/treesitter.lua")
  print(status_ok)
  return
end

configs.setup {
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
  -- textobjects = {
  --   select = {
  --     enable = false,
  --     lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
  --     keymaps = {
  --       -- You can use the capture groups defined in textobjects.scm
  --       ["aa"] = "@parameter.outer",
  --       ["ia"] = "@parameter.inner",
  --       ["af"] = "@function.outer",
  --       ["if"] = "@function.inner",
  --       ["ac"] = "@class.outer",
  --       ["ic"] = "@class.inner",
  --     },
  --   },
  --   move = {
  --     enable = false,
  --     set_jumps = true, -- whether to set jumps in the jumplist
  --     goto_next_start = {
  --       ["]m"] = "@function.outer",
  --       ["]]"] = "@class.outer",
  --     },
  --     goto_next_end = {
  --       ["]M"] = "@function.outer",
  --       ["]["] = "@class.outer",
  --     },
  --     goto_previous_start = {
  --       ["[m"] = "@function.outer",
  --       ["[["] = "@class.outer",
  --     },
  --     goto_previous_end = {
  --       ["[M"] = "@function.outer",
  --       ["[]"] = "@class.outer",
  --     },
  --   },
  --   swap = {
  --     enable = false,
  --     swap_next = {
  --       ["<leader>a"] = "@parameter.inner",
  --     },
  --     swap_previous = {
  --       ["<leader>A"] = "@parameter.inner",
  --     },
  --   },
  -- },
}
