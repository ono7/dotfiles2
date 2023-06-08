local status_ok, my_gitsigns = pcall(require, "gitsigns")

if not status_ok then
  print("gitsigns not loaded - plugins/gitsigns.lua")
  return
end

my_gitsigns.setup({
  on_attach = function(bufnr)
    if not vim.api.nvim_buf_is_valid(bufnr) then
      return
    end
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    -- Actions
    map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
    map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
    map("n", "<leader>ss", gs.stage_buffer)
    map("n", "<leader>su", gs.undo_stage_hunk)
    map("n", "<leader>sR", gs.reset_buffer)
    map("n", "<leader>sp", gs.preview_hunk)
    map("n", "<leader>sb", function()
      gs.blame_line({ full = true })
    end)
    -- map("n", "<leader>tb", gs.toggle_current_line_blame)
    map("n", "<leader>sd", gs.diffthis)
    map("n", "<leader>sD", function()
      gs.diffthis("~")
    end)
    -- map("n", "<leader>td", gs.toggle_deleted)

    -- Text object
    -- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end,
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
})
