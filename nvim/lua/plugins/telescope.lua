local opt = { noremap = true, silent = true }
local silent = { noremap = true, silent = true }
local m = vim.api.nvim_set_keymap
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
		previewer = true,
		layout_strategy = "flex",
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
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

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

k("n", "<c-w>", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
k("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

k({ "n", "x" }, "<c-f>", "<cmd>lua require('telescope.builtin').find_files({no_ignore=true})<cr>", opt)
k({ "n", "x" }, "<leader>fd", "<cmd>lua require('telescope.builtin').find_files({ cwd = '.' })<cr>", opt)
k("n", "<c-z>", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opt)
-- k({ "n", "c", "x" }, "<c-z>", "<cmd>lua require('telescope.builtin').grep_string()<cr>", opt)
k({ "n", "c", "x" }, "<c-s>", "<cmd>lua require('telescope.builtin').git_files({ show_untracked = true })<cr>", silent)
k({ "n", "x" }, "<leader><leader>", "<cmd>lua require('telescope.builtin').buffers()<cr>", opt)
k("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opt)
k(
	"n",
	"<leader>vc",
	"<cmd>lua require('telescope.builtin').find_files({ cwd = '~/.dotfiles', hidden = true, show_untracked = true, no_ignore = true })<cr>",
	opt
)
