-- NOTE: keybinds only work using kitty 2022-11-12

local silent, k = { silent = true }, vim.keymap.set
local ui = require("harpoon.ui")
local mark = require("harpoon.mark")

k("n", "<c-m>",mark.add_file)
k("n", "<m-m>", ui.toggle_quick_menu)
k("n", "<m-n>", function() ui.nav_file(1) end, silent)
k("n", "<m-e>", function() ui.nav_file(2) end, silent)
k("n", "<m-i>", function() ui.nav_file(3) end, silent)
k("n", "<m-o>", function() ui.nav_file(4) end, silent)

-- k("n", "<m-m>", ui.toggle_quick_menu)
-- k("n", "<m-n>", function() ui.nav_file(1) end, silent)
-- k("n", "<m-e>", function() ui.nav_file(2) end, silent)
-- k("n", "<m-i>", function() ui.nav_file(3) end, silent)
-- k("n", "<m-o>", function() ui.nav_file(4) end, silent)
