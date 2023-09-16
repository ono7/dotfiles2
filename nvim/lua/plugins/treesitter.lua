local status_ok, configs = pcall(require, "nvim-treesitter.configs")

if not status_ok then
  -- loading these when treesitter is running breaks everything
  vim.opt.synmaxcol = 512
  vim.cmd("set synmaxcol=512")
  vim.cmd("syntax sync minlines=256")
  vim.cmd("syntax sync maxlines=300")
  vim.cmd [[syntax on]]
  print("problem loading treesitter - plugins/treesitter.lua, enabled classic syntax on")
  return
end

configs.setup {
  sync_install = false,
  auto_install = true,
  indent = { enable = false, disable = { "python" } },
  highlight = {
    use_languagetree = true,
    max_file_lines = 1000,
    enable = true,
    additional_vim_regex_highlighting = false,
    indent = { enable = false },
    incremental_selection = { enable = false },
    textobjects = { enable = true },
    rainbow = {
      max_file_lines = 1000,
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
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["aa"] = "@parameter.outer",
        ["ai"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["at"] = "@class.outer",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["at"] = "@comment.outer",
        -- You can optionally set descriptions to the mappings (used in the desc parameter of
        -- nvim_buf_set_keymap) which plugins like which-key display
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        -- You can also use captures from other query groups like `locals.scm`
        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V',  -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true of false
      include_surrounding_whitespace = true,
    },
  },
}
