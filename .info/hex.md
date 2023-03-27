# convert hex to decimal to string

`0x68` =  take first number 6, multiple time 16 (hex is base16), add the last number `8`
  = 6 * 16 = 96 + 8 = 104, in string `fmt.Println(string(104))` --> out 
