--- iterate over strings using string.byte

print(string.rep("-", 20))

local start = os.clock()

local str = " a"
str_t = {string.byte(str, 1, #str)}
counter = 0

for i = 1, #str_t do
  if str_t[i] == string.byte(" ") or string.byte("a") then
    print(str_t[i])
    counter = counter + 1
  end
end
print(string.format("found %s", counter))

local elapsed = os.clock() - start

print(string.format("V1: elapsed time: %.3f", elapsed))

-- iterate over strings using string.sub

for c in str:gmatch "." do
  -- do something with c
  print(c)
end
