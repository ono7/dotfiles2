local opt = { noremap = true, silent = true }
local silent = { noremap = true, silent = true }
local k = vim.keymap.set

local function get_git_root()
  local dot_git_path = vim.fn.finddir(".git", ".;")
  if dot_git_path then
    return vim.fn.fnamemodify(dot_git_path, ":h")
  else
    return "."
  end
end

local data = assert(vim.fn.stdpath "data") --[[@as string]]


local actions = require "telescope.actions"

require("telescope").setup {
  pickers = {
    find_files = {
      theme = "dropdown",
    },
    git_files = {
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
  builtin.find_files { previewer = false, cwd = '~/.dotfiles', hidden = true, show_untracked = true, no_ignore = true }
end)


k("n", "<leader>fw", function()
  local word = vim.fn.expand("<cword>")
  builtin.grep_string { search = word }
end, opt)

k("n", "<leader>fW", function()
  local word = vim.fn.expand("<cWORD>")
  builtin.grep_string { search = word }
end, opt)


k("n", "<leader>fd", function() builtin.diagnostics({ previewer = false }) end, opt)


k("n", "<leader>g", function()
  builtin.live_grep { vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '-u' }, use_regex = true }
end, opt)

k({ "n", "x" }, "<c-\\>", function() builtin.buffers({ previewer = false }) end, opt)

k({ "n", "x" }, "<c-f>", function()
  -- builtin.find_files({ no_ignore = false, hidden = true, cwd = get_git_root() })
  builtin.find_files({ no_ignore = true, hidden = true, previewer = false })
end, opt)

k({ "n", "x" }, "<c-p>", function()
  -- builtin.find_files({ no_ignore = false, hidden = true, cwd = get_git_root() })
  builtin.git_files({ no_ignore = false, hidden = true, previewer = false })
end, opt)




k("n", "<leader>ff", function()
  vim.ui.input({ prompt = "Enter directory path: " }, function(input)
    require("telescope.builtin").find_files({ cwd = input })
  end)
end)
