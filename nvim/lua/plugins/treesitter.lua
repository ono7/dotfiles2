local status_ok, configs = pcall(require, "nvim-treesitter.configs")

if not status_ok then
  print("problem loading treesitter - plugins/treesitter.lua")
  return
end

configs.setup({
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
    disable = function(lang, bufnr)
      return vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) > 1048576
    end,
  },
  ensure_installed = {
    "vimdoc",
    "bash",
    "go",
    "javascript",
    "typescript",
    "markdown",
    "terraform",
    "json",
    "lua",
    "make",
    "python",
    "regex",
    "vim",
    "yaml",
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
  },
})
