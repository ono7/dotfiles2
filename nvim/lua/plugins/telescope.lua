local opt = { noremap = true, silent = true }
local silent = { noremap = true, silent = true }
local k = vim.keymap.set
--
--
--
-- local status_ok, configs = pcall(require, "telescope")
--
-- if not status_ok then
--   print("telescope not loaded - plugins/telescope.lua")
--   print(status_ok)
--   return
-- end
--
-- local actions_setup, actions = pcall(require, "telescope.actions")
--
-- if not actions_setup then
--   print("telescope.actions not loaded")
--   return
-- end
--
-- -- configs.load_extension("git_worktree")
-- configs.load_extension("fzf")
-- configs.load_extension("smart_history")
-- -- configs.load_extension("recent_files")
--

local function get_git_root()
  local dot_git_path = vim.fn.finddir(".git", ".;")
  if dot_git_path then
    return vim.fn.fnamemodify(dot_git_path, ":h")
  else
    return "."
  end
end
--
-- local find_all_files_cmd = {
--   "fd",
--   "--type", "f",
--   "--type", "l",
--   "--follow",
--   "--color=never",
--   "--hidden",
--   "--no-ignore",
--   "-g '!.*cache/*'",
--   "-g '!.git/*'",
--   "-E", "*.hex",
-- }
--
--
-- configs.setup({
--   defaults = {
--     previewer = false,
--     preview_cutoff = 1,
--     -- path_display = {
--     --   "smart"
--     -- },
--     layout_strategy = "flex", -- flex (shows preview)
--     file_ignore_patterns = {
--       ".git/",
--       ".venv/",
--       ".cache",
--       "__pycache__",
--       "%.o",
--       "%.a",
--       "%.out",
--       "%.pdf",
--       "%.mkv",
--       "%.zip",
--       '%.npz',
--       '%.aux',
--       '%.otf',
--       '%.ttf',
--       '%.mp3',
--       '%.sfd',
--       '%.fmt',
--       '%.jpg',
--       '%.png',
--     },
--     extensions = {
--       fzf = {
--         fuzzy = true,                   -- false will only do exact matching
--         override_generic_sorter = true, -- override the generic sorter
--         override_file_sorter = true,    -- override the file sorter
--         case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
--       },
--       history = {
--         path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
--         limit = 100,
--       },
--     },
--     -- file_previewer = require("telescope.previewers").vim_buffer_cat.new,
--     -- grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
--     qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
--
--     mappings = {
--       i = {
--         ["<c-k>"] = actions.move_selection_previous,
--         ["<c-j>"] = actions.move_selection_next,
--         -- ["<c-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
--         ["<C-q>"] = actions.smart_add_to_qflist + actions.open_qflist,
--         -- ['<C-u>'] = false,
--         -- ['<C-d>'] = false,
--       },
--     },
--   },
-- })
--
--
-- local builtin = require("telescope.builtin")
--
-- -- k("n", "<c-p>", function() require 'telescope'.extensions.recent_files.pick({ previewer = false }) end, opt)
--
--
-- k("n", "<leader>ff",
--   function()
--     builtin.git_files({ show_untracked = true, no_ignore = false, hidden = true, previewer = false, shorten_path = true })
--   end,
--   silent)
--
-- k("n", "<leader>g",
--   function()
--     builtin.live_grep { vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '-u' }, use_regex = true }
--   end,
--   opt)
--
--
-- -- k("n", "<leader>o", function() require('telescope').extensions.git_worktree.git_worktrees() end, opt)
-- -- k("n", "<leader>O", function() require('telescope').extensions.git_worktree.create_git_worktree() end, opt)
--
-- -- k({ "n", "x" }, "<leader><leader>", function() builtin.buffers() end, opt)
--
--
-- -- get what is visual selected and pass it to live_grep, hacky but works
-- k('v', '<leader>f', 'y<ESC>:Telescope live_grep default_text=<c-r>0<CR>', silent)

local data = assert(vim.fn.stdpath "data") --[[@as string]]


local actions = require "telescope.actions"

require("telescope").setup {
  pickers = {
    find_files = {
      theme = "dropdown",
    }
  },
  extensions = {
    wrap_results = true,

    fzf = {},
    history = {
      path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
      limit = 100,
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {},
    },
  },
  defaults = {
    layout_config = {
      vertical = { width = 0.5 },
    },
    file_ignore_patterns = {
      ".git/",
      ".venv/",
      ".cache",
      "__pycache__",
      "%.o",
      "%.a",
      "%.out",
      "%.pdf",
      "%.mkv",
      "%.zip",
      '%.npz',
      '%.aux',
      '%.otf',
      '%.ttf',
      '%.mp3',
      '%.sfd',
      '%.fmt',
      '%.jpg',
      '%.png',
    },
  },

  mappings = {
    i = {
      ["<c-k>"] = actions.move_selection_previous,
      ["<c-j>"] = actions.move_selection_next,
      -- ["<c-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      ["<C-q>"] = actions.smart_add_to_qflist + actions.open_qflist,
      -- ['<C-u>'] = false,
      -- ['<C-d>'] = false,
    },
  },
}

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "smart_history")
pcall(require("telescope").load_extension, "ui-select")

local builtin = require "telescope.builtin"

-- vim.keymap.set("n", "<c-f>", builtin.find_files)
vim.keymap.set("n", "<space>ft", builtin.git_files)
vim.keymap.set("n", "<space>fh", builtin.help_tags)
vim.keymap.set("n", "<space>fg", builtin.live_grep)
vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find)

-- vim.keymap.set("n", "<space>gw", builtin.grep_string)
--
-- vim.keymap.set("n", "<space>fa", function()
--   ---@diagnostic disable-next-line: param-type-mismatch
--   builtin.find_files { cwd = vim.fs.joinpath(vim.fn.stdpath "data", "lazy") }
-- end)

-- vim.keymap.set("n", "<space>en", function()
--   builtin.find_files { cwd = vim.fn.stdpath "config" }
-- end)

-- vim.keymap.set("n", "<space>eo", function()
--   builtin.find_files { cwd = "~/.config/nvim-backup/" }
-- end)


k("n", "<leader>vc", function()
  builtin.find_files { cwd = '~/.dotfiles', hidden = true, show_untracked = true, no_ignore = true }
end)


k("n", "<leader>fw", function()
  local word = vim.fn.expand("<cword>")
  builtin.grep_string { search = word }
end, opt)

k("n", "<leader>fW", function()
  local word = vim.fn.expand("<cWORD>")
  builtin.grep_string { search = word }
end, opt)


k("n", "<leader>fd", function() builtin.diagnostics() end, opt)


k("n", "<leader>g", function()
  builtin.live_grep { vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '-u' }, use_regex = true }
end, opt)

k({ "n", "x" }, "<c-\\>", function() builtin.buffers() end, opt)

k({ "n", "x" }, "<c-f>", function()
  -- builtin.find_files({ no_ignore = false, hidden = true, cwd = get_git_root() })
  builtin.find_files({ no_ignore = false, hidden = true, previewer = false })
end, opt)
