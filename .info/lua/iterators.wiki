= Contents =

  - [[#iterators|iterators]]
    - [[#iterators#ipairs()|ipairs()]]
    - [[#iterators#pairs()|pairs()]]
    - [[#iterators#string.gmatch()|string.gmatch()]]

= iterators =


== ipairs() ==

  index pairs, allows to traverse the array part of the table

{{{lua
tb1 = {"a", "b", "c", k1 = "ka", k2 = "kb"}

for i, v in ipairs(tb1) do
  -- only includes the index values in the table
  print(i, v)
end
}}}

== pairs() ==

  allows to traverse the k,v pairs on a table

{{{lua
tb1 = {"a", "b", "c", k1 = "ka", k2 = "kb"}

for k, v in pairs(tb1) do
  -- also includes the index ones
  print(k, v)
end
}}}

== string.gmatch() ==

* gmatch returns an iterator obj

{{{lua
for cc in string.gmatch("AABBCCDDFFZZ", "%x%x") do
  -- returns iterator, prints 2 hex digits fromm match
  print(cc)
end

--[[

  AA
  BB
  CC
  DD
  FF
  -- excludes ZZ since its not valid hex

--]]
for word in string.gmatch("this are some words", "%S+") do
  -- matches non-spaces "%S+"
  print(word)
end

--[[

  this
  are
  some
  words

--]]
}}}
