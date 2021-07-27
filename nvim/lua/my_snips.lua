--- testing snips ---
local m = vim.api.nvim_set_keymap
local opt = {noremap = true}
-- local silent = {noremap = true, silent = true}

require "snippets".set_ux(require "snippets.inserters.vim_input")

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
#!/usr/bin/env python
""" $0

    ${=os.date()}

    __author__ = 'Jose Lima'

"""
]],
    docs = [["""$0"""]],
    st = [[__import__("pdb").set_trace()]],
    it = [[__import__("ipdb").set_trace(context=5)]],
    rt = [[__import__("rpdb").set_trace()  # port 4444]],
    package = [[
""" package setup """

from setuptools import setup, find_packages

setup(
    name='$0',
    version='0.1.0',
    license='unlicensed',
    description='',
    author='Jose Lima',
    author_email='',
    url='',
    packages=find_packages(where='src'),
    package_dir={'': 'src'},
    install_requires=[],
    # extras_require={'mongo': 'pymongo'},
    entry_points={
        'console_scripts': [
        # "deps" = tasks.cli:tasks_cli',
        ]
},
)
]]
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
  },
  cfg = {
    h = [[
localhost ansible_connection=local

[all:vars]

ansible_connection = network_cli
ansible_network_os = nxos
ansible_user= "jose.lima"

# ansible_become = yes
# ansible_become_method = enable
# ansible_ssh_pass = ""

timeout = 5

[group1]
$0

[group1:vars]
]]
  }
}
