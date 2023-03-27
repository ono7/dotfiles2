= working with hex =


string.byte - converts string to byte characters
string.char - converts them back to characters

{{{lua

> x = 'this is a test'
> string.byte(x, 1, #x)
116     104     105     115     32      105     115     32     97       32      116     101     115     116
> string.char(string.byte(x, 1, #x))
this is a test
>

}}}
