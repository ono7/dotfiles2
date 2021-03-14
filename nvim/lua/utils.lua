-- utils.lua

local M = {}
local cmd = vim.cmd

function M.create_augroup(autocmds, name)
    -- https://icyphox.sh/blog/nvim-lua/
    cmd('augroup ' .. name)
    cmd('autocmd!')
    for _, autocmd in ipairs(autocmds) do
        cmd('autocmd ' .. table.concat(autocmd, ' '))
    end
    cmd('augroup END')
end

return M
