= shellcoding snips for lua =

* convert string to hex


{{{lua

> s = '\x42\x42\x42'
> x = s:gsub('\\x(%x%x)', function(x) return string.char(tonumber(x, 16)) end)
> x
BBB

}}}
