local status_ok, lualine = pcall(require, "lualine")

if not status_ok then
	print("lualine not loaded - plugins/lualine.lua")
	return
end

lualine.setup({
	options = {
		theme = "catppuccin",
		-- ... the rest of your lualine config
	},
})
