# converts binary to hex in postscript format (continious plain string)

- this makes it easier to work with the binary since we dont have to remove junk
  with vim we can just join lines and remove spaces

xxd -ps binary.dll

# vim s/\v((..){2048})/"\1"\r/g

at 2048 bytes encapsulate chunks with " " and add return at the end of each chunc

can be used to add other meta data buffer += "chunk" etc..

# elevate to a fully interactive shell

python -c 'import pty;pty.spawn("/bin/bash")'

# signed int/unsigned int

In laymen's terms an unsigned int is an integer that can not be negative and
thus has a higher range of positive values that it can assume. A signed int is
an integer that can be negative but has a lower positive range in exchange for
more negative values it can assume.
