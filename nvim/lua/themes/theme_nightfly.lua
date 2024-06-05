------------------------------ fly ------------------------------

vim.cmd("set termguicolors")
vim.g.nightflyTransparent = true
vim.cmd("colorscheme nightfly")
vim.cmd("hi! clear Identifier")
vim.cmd("hi! NightflyWatermelon guifg=#f48fb1")
vim.cmd("hi! Comment guifg=#8a889d")
vim.cmd("hi! clear Type")
vim.cmd("hi! clear WinBar")
vim.cmd("hi! clear Function")
vim.cmd("hi! link @constructor NightflyBlue")
vim.cmd("hi! link @type.builtin NightflyGreen")
vim.cmd("hi! link IncSearch WildMenu")
vim.cmd("hi! link @punctuation.bracket nightflyTransparent")
vim.cmd("hi! clear WinBarNC")
vim.cmd("hi! link VertSplit Whitespace")
vim.cmd("hi! link @conceal LineNr")
vim.cmd("hi! link Number Normal")

