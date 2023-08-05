--- backup functions from init.lua
local cmd, g, m, k = vim.cmd, vim.g, vim.api.nvim_set_keymap, vim.keymap.set

function _G.remove_whitespace()
	cmd([[let old = @/]])
	cmd([[keepjumps %retab!]])
	cmd([[keepjumps %s/\s\+$//e]])
	cmd([[let @/ = old]])
	cmd("update!")
end

function _G.format_and_write()
	-- if g.format == 1 then
	_G.remove_whitespace()
	cmd("FormatWrite")
	-- end
end

-- m("n", "<leader>r", ":call v:lua.remove_whitespace()<cr>", silent)
-- m("v", "<leader>r", "<c-c>:call v:lua.remove_whitespace()<cr>", silent)
-- m("n", "<leader>w", [[:call v:lua.format_and_write()<cr>]], silent)
-- m("v", "<leader>w", [[<c-c>:call v:lua.format_and_write()<cr>]], silent)

