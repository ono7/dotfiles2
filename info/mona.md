### moma: refs

  https://www.corelan.be/index.php/2011/07/14/mona-py-the-manual/

### moma: shortcuts
  alt-l = logs
  f2 - break toggle
  f9 run
  alt-s "search for command sequence"

### moma: setup working log directory

!mona config -set workingfolder c:\logs\%p

### moma: list of mona related shortcuts

  !mona jmp -r ESP
  !mona f -type instr -s "pop esp#ret"
    find instructionk:
      pop esp
      ret

### moma: generate opcodes

  !mona assemble -s "pop eax#pop ebx#ret"

    generates opcodes for
    pop eax
    pob ebx
    ret
  returns:  [ 58 5b c3 ]

### moma:  getting help

  !mona help find

### moma:  filtering badchars

* !mona seh -cp nonull
  only return pointers with no nulls

* -cpb '\x00\x0a\x0d'
  filter bad characters, supposed the exploit cant contain bad chars

### moma:  find strings

!mona f -type asc -s "w00t"

### moma:  pattern, create/find

!mona pc 6000
!mona pattern_offset 0x7A46317A (where 0x7A46317A is the value of EIP at the crash time)
!mona findmsp


### moma:  findng bad characters (explanation)

To find bad characters we have to compare the payload in memory vs the payload
in a bytearray.bin file that contains the ascii table to find characters not
allowed in our payload.



```
vim:
  :r!bytearray "00,0a,0d"

### moma:  bytearray bad chars:  \x00\x0a\x0d

byte_array = b"\x01\x02..."

```
this generates the bytearray payload

byte_array must reside in an area of memory we control and had enough space, esp?

buffer = b"A" * 5000 + byte_array + rest_of_buffer

### mona: bytearray compare / search

-a is the address where the pattern is expected, leave without to do a full memory search

!mona compare -f z:\bytearray.bin -a 0x11223344 (esp?)

rinse and repeat until all bad chars are found

