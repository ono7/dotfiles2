local status_ok, bufferline = pcall(require, "bufferline")

if not status_ok then
	print("bufferline not loaded - plugins/bufferline.lua")
	return
end

bufferline.setup({
	auto_hide = true,
	animation = false,
	-- separator_style = "slant",
  separator_style = {"|", "|"}
})

local opt = { noremap = true, silent = true }

vim.keymap.set("n", "<s-Tab>", ":BufferPrevious<CR>", { silent = true })
vim.keymap.set("n", "<Tab>", ":BufferNext<CR>", { silent = true })
vim.keymap.set({ "n", "x" }, ",d", ":BufferClose!<cr>", { silent = true })
