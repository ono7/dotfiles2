vim.filetype.add({
  extension = {
    -- h = function()
    --   -- Use a lazy heuristic that #including a C++ header means it's a
    --   -- C++ header
    --   if vim.fn.search("\\C^#include <[^>.]\\+>$", "nw") >= 1 then
    --     return "cpp"
    --   end
    --   return "c"
    -- end,
    csv = "csv",
    cl = "opencl",
    env = "env",
    j2 = "jinja",
    conf = "config",
    -- yml = function()
    --   if vim.fn.search([[hosts:\|tasks:]], 'nw') >= 1 then
    --     return "yaml.ansible"
    --   end
    --   return "yaml"
    -- end,
    yml = "yaml.ansible",
    md = "markdown",
    ts = "typescript",
    tf = "terraform",
    tfvars = "terraform",
    tfstate = "json",
    hcl = "terraform",
    asm = "nasm",
  },
})
