### assembly: mov
  moves contents from mem to registers, registers to mem

  dst, src cannot be two labels
  first move data to a register then move data from the register to

  ```nasm

  v1 db 0xaa
  v2 db 0xbb

  mov al, v1
  mov ah, v2
  mov ah, byte [v2] ; move 0xaa to v2
  mov al, byte [v1] ; move 0xaa to v1
  exch al, ah ; exchange values
  ```


### assembly: (general) opcodes

; save and restore all registers
popad
popfd

c3 = ret
90 = nop

58 = pop eax
59 = pop ecx

eb = short jmp
ja = jump if above (useful for dec esp, dec esp, ja 11)
  The opcode for a short jump is eb, followed by the jump distance. In other
  words, a short jump of 6 bytes corresponds with opcode eb 06. We need to fill
  4 bytes, so we must add 2 NOP’s to fill the 4 byte space. So the next SEH field
  must be overwritten with 0xeb,0x06,0x90,0x90

### assembly: using peda for opcodes

you can commma separate the opcodes to get them all in one line

  gdb-peda$ assemble
  Instructions will be written to stdout
  iasm|0xdeadbef1> push esp;ret
  hexify: "\x54\xc3"
  iasm|0xdeadbef3>

