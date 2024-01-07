local opt = { noremap = true, silent = true }
local silent = { noremap = true, silent = true }
local k = vim.keymap.set

local status_ok, configs = pcall(require, "telescope")

if not status_ok then
  print("telescope not loaded - plugins/telescope.lua")
  return
end

local actions_setup, actions = pcall(require, "telescope.actions")

if not actions_setup then
  print("telescope.actions not loaded")
  return
end

configs.load_extension("fzf")


local function get_git_root()
  local dot_git_path = vim.fn.finddir(".git", ".;")
  if dot_git_path then
    return vim.fn.fnamemodify(dot_git_path, ":h")
  else
    return "."
  end
end

configs.setup({
  defaults = {
    previewer = false,
    preview_cutoff = 1,
    layout_strategy = "flex", -- flex (shows preview)
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
    extensions = {
      fzf = {
        fuzzy = true,               -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case",   -- or "ignore_case" or "respect_case"
      },
      -- ["ui-select"] = {},
    },
    -- file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    -- grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    -- qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

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
  },
})


-- Telescope live_grep search_dirs={'%'}
-- k("n", "<c-/>", function()
--   -- You can pass additional configuration to telescope to change theme, layout, etc.
--   require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
--     -- winblend = 10,
--     previewer = false,
--   }))
-- end, { desc = "[/] Fuzzily search in current buffer" })


k("n", "<c-p>", function() require("telescope.builtin").oldfiles() end, opt)

k({ "n", "x" }, "<leader>ff", function()
  require('telescope.builtin').find_files({ no_ignore = true, hidden = true, cwd = get_git_root() })
end, opt)

k({ "n", "x" }, "<c-f>", function()
  -- require('telescope.builtin').find_files({ cwd = vim.fn.expand('%:p:h') })
  require('telescope.builtin').find_files()
end, opt)

k({ "n", "x" }, "<leader>fg",
  function()
    require('telescope.builtin').git_files({ show_untracked = true, no_ignore = false, hidden = true })
  end,
  silent)

k("n", "<leader>g",
  function()
    require('telescope.builtin').live_grep { vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '-u' }, use_regex = true }
  end,
  opt)

k("n", "<leader>fg",
  function()
    require('telescope.builtin').live_grep { vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '-u' }, use_regex = true, cwd = get_git_root() }
  end,
  opt)
k("n", "<leader>fd", function() require('telescope.builtin').diagnostics() end, opt)

k({ "n", "x" }, "<space>fb", function() require('telescope.builtin').buffers() end, opt)
k(
  "n",
  "<leader>vc",
  function() require('telescope.builtin').find_files({ cwd = '~/.dotfiles', hidden = true, show_untracked = true, no_ignore = true }) end
  , opt
)

k(
  "n",
  "<leader>fw",
  function()
    require('telescope.builtin').live_grep({ cwd = '~/notes', hidden = true, show_untracked = true, no_ignore = true })
  end,
  opt
)
