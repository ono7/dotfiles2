--- testing snips ---
local m = vim.api.nvim_set_keymap
local opt = {noremap = true}
-- local silent = {noremap = true, silent = true}

m("i", "<c-l>", [[<cmd>lua return require'snippets'.expand_or_advance(1)<CR>]], opt)
require "snippets".snippets = {
  _global = {
    -- Insert a basic snippet, which is a string.
    todo = "${=vim.bo.commentstring:gsub('%%s', '')}TODO: ${=os.date('%x')} | ",
    date = "${=os.date()}",
    time = "${=os.date('%X') .. ' CDT'} "
  },
  python = {
    h = [[
#/usr/bin/env python
""" $0

    ${=os.date()}

    __author__ = 'Jose Lima'

"""
]],
    docs = [["""$0"""]]
  },
  yaml = {
    h = [[
---
################################################################################
#                                  Jose.Lima                                   #
#                     Network Optimization and Automation                      #
################################################################################

- name: $0
  hosts:
  gather_facts: false

  tasks:
    - name:]]
  }
}
