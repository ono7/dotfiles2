local status_ok, null_ls = pcall(require, "null-ls")

local MYHOME = os.getenv("HOME")

if not status_ok then
  print("null-ls not loaded - plugins/null_ls.lua")
  return
end

local format = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_prev({ float = true })<CR>")
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_next({ float = true })<CR>")

null_ls.setup({
  debug = false,
  sources = {
    -- diagnostics.pylint
    diagnostics.write_good.with({
      -- npm install -g write-good
      filetypes = { "text" },
    }),
    -- pip install black pylint
    format.black.with({
      command = MYHOME .. "/.virtualenvs/prod3/bin/python3",
      args = { "-m", "black", "--fast", "--line-length", "88", "-" },
      stdin = true
    }
    ),
    format.prettier.with({
      filetypes = {
        "javascript",
        "typescript",
        "css",
        "scss",
        "html",
        "json",
        "yaml",
        "markdown",
        "graphql",
      },
    }),
    -- cargo install stylua
    -- format.stylua,
    -- format.gofmt,
    -- format.goimports,
  },
})
