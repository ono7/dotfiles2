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

configs.setup({
  defaults = {
    previewer = false,
    preview_cutoff = 1,
    layout_strategy = "flex", -- flex (shows preview)
    file_ignore_patterns = {
      ".git/",
      ".cache",
      "__pycache__",
      "%.o",
      "%.a",
      "%.out",
      "%.pdf",
      "%.mkv",
      "%.zip",
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

-- k({ "n", "x" }, "<c-f>", "<cmd>lua require('telescope.builtin').find_files({ cwd = '.' })<cr>", opt)
k("n", "<c-p>", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
k({ "n", "x" }, "<leader>ff", "<cmd>lua require('telescope.builtin').find_files({ no_ignore=true, hidden=true })<cr>",
  opt)
k({ "n", "x" }, "<c-f>", "<cmd>lua require('telescope.builtin').find_files( { cwd = vim.fn.expand('%:p:h') })<cr>")
k({ "n", "x" }, "<leader>fg",
  "<cmd>lua require('telescope.builtin').git_files({ show_untracked = true, no_ignore=false, hidden=true })<cr>",
  silent)
k("n", "<leader>g",
  "<cmd>lua require('telescope.builtin').live_grep{ vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '-u' }, use_regex=true }<cr>",
  opt)
k("n", "<leader>fd", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", opt)

-- k("n", "<leader>fb", "<cmd>lua require('telescope.builtin').live_grep({grep_open_files = true})<cr>", opt)

-- k({ "n", "c", "x" }, "<c-z>", "<cmd>lua require('telescope.builtin').grep_string()<cr>", opt)
-- k({ "n", "c", "x" }, "<leader>ft", "<cmd>lua require('telescope.builtin').git_files({ show_untracked = true })<cr>",
k({ "n", "x" }, "<space>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", opt)
k(
  "n",
  "<leader>vc",
  "<cmd>lua require('telescope.builtin').find_files({ cwd = '~/.dotfiles', hidden = true, show_untracked = true, no_ignore = true })<cr>",
  opt
)
k(
  "n",
  "<leader>fw",
  "<cmd>lua require('telescope.builtin').live_grep({ cwd = '~/notes', hidden = true, show_untracked = true, no_ignore = true })<cr>",
  opt
)
