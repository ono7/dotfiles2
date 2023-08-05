### gdb: refs

https://gist.githubusercontent.com/williballenthin/8bd6e29ad8504b9cb308039f675ee889/raw/d30ea737de68c2fce44fb65da6254d22970dc9e6/gdb.md

### gdb: info files


(gdb) info files
Symbols from "/opt/pew".
Local exec file:
        `/opt/pew', file type elf64-x86-64.
        Entry point: 0x400ae0
        0x0000000000400238 - 0x0000000000400254 is .interp
        0x0000000000400254 - 0x0000000000400274 is .note.ABI-tag
        0x0000000000400274 - 0x0000000000400298 is .note.gnu.build-id
        0x0000000000400298 - 0x00000000004002c0 is .gnu.hash
        0x00000000004002c0 - 0x0000000000400548 is .dynsym
        0x0000000000400548 - 0x0000000000400693 is .dynstr
        0x0000000000400694 - 0x00000000004006ca is .gnu.version
        ...


### gdb: breakpoints

### gdb: create breakpoint

note use of `*` to indicate memory address.
also not use of leading hex `0x`.


(gdb) break *0x400ae0
Breakpoint 1 at 0x400ae0


### gdb: list breakpoints


(gdb) info breakpoints
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x0000000000400ae0
        breakpoint already hit 1 time
2       breakpoint     keep y   0x0000000000403d86
3       breakpoint     keep y   0x0000000000403ea5


### gdb: delete breakpoint


(gdb) info breakpoints
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x0000000000400ae0
        breakpoint already hit 1 time
2       breakpoint     keep y   0x0000000000403d86
        breakpoint already hit 1 time
3       breakpoint     keep y   0x0000000000403ea5
4       breakpoint     keep y   0x00000000003d7e30
5       breakpoint     keep y   0x0000000000403e4f
(gdb) delete breakpoints 4
(gdb) info breakpoints
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x0000000000400ae0
        breakpoint already hit 1 time
2       breakpoint     keep y   0x0000000000403d86
        breakpoint already hit 1 time
3       breakpoint     keep y   0x0000000000403ea5
5       breakpoint     keep y   0x0000000000403e4f


### gdb: run


(gdb) run
Starting program: /opt/pew
Breakpoint 1, 0x0000000000400ae0 in ?? ()


### gdb: continue

resume execution after pausing at a breakpoint.


(gdb) c
Continuing.


### gdb: jump

resume execution from a given address.
this is like `set $pc = 0xADDR; continue;`.

note the use of `*` to indicate the raw address from which to start.


(gdb) jump *0x403EC2
Continuing at 0x403ec2.


### gdb: registers


(gdb) info registers
rax            0x1c     28
rbx            0x0      0
rcx            0x7fffffffedb8   140737488350648
rdx            0x7ffff7de7ab0   140737351940784
rsi            0x1      1
rdi            0x7ffff7ffe168   140737354129768
rbp            0x0      0x0
rsp            0x7fffffffeda0   0x7fffffffeda0
r8             0x7ffff7ffe6f8   140737354131192
r9             0x0      0
r10            0x3c     60
r11            0xb      11
r12            0x400ae0 4197088
r13            0x7fffffffeda0   140737488350624
r14            0x0      0
r15            0x0      0
rip            0x400ae0 0x400ae0
eflags         0x202    [ IF ]
cs             0x33     51
ss             0x2b     43
ds             0x0      0
es             0x0      0
fs             0x0      0
gs             0x0      0


### gdb: disassemble

by default, disassembles entire surrounding function.

use commas to separate arguments.

use `+length` to specify number of bytes to disassemble.


(gdb) disassemble 0x400ae0,+0x10
Dump of assembler code from 0x400ae0 to 0x400af0:
=> 0x0000000000400ae0:  xor    %ebp,%ebp
   0x0000000000400ae2:  mov    %rdx,%r9
   0x0000000000400ae5:  pop    %rsi
   0x0000000000400ae6:  mov    %rsp,%rdx
   0x0000000000400ae9:  and    $0xfffffffffffffff0,%rsp
   0x0000000000400aed:  push   %rax
   0x0000000000400aee:  push   %rsp
   0x0000000000400aef:  mov    $0x403f80,%r8
End of assembler dump.


default flavor is AT&T syntax. use `set disassembly-flavor intel` to set to Intel:


(gdb) set disassembly-flavor intel
(gdb) disassemble 0x400ae0,+0x10
Dump of assembler code from 0x400ae0 to 0x400af0:
=> 0x0000000000400ae0:  xor    ebp,ebp
   0x0000000000400ae2:  mov    r9,rdx
   0x0000000000400ae5:  pop    rsi
   0x0000000000400ae6:  mov    rdx,rsp
   0x0000000000400ae9:  and    rsp,0xfffffffffffffff0
   0x0000000000400aed:  push   rax
   0x0000000000400aee:  push   rsp
   0x0000000000400aef:  mov    r8,0x403f80
End of assembler dump.


enable showing of next instruction on each break/step:

(gdb) set disassemble-next-line on

### gdb: step over / navigation


TODO: nexti

### gdb: step into

TODO: stepi

### gdb: memory map

(gdb) info proc mappings
process 8
Mapped address spaces:

          Start Addr           End Addr       Size     Offset objfile
            0x400000           0x405000     0x5000        0x0 /opt/pew
            0x604000           0x605000     0x1000     0x4000 /opt/pew
            0x605000           0x614000     0xf000     0x5000 /opt/pew
      0x7ffff77e4000     0x7ffff79a4000   0x1c0000        0x0 /lib/x86_64-linux-gnu/libc-2.23.so
      0x7ffff79a4000     0x7ffff7ba4000   0x200000   0x1c0000 /lib/x86_64-linux-gnu/libc-2.23.so
      0x7ffff7ba4000     0x7ffff7ba8000     0x4000   0x1c0000 /lib/x86_64-linux-gnu/libc-2.23.so
      0x7ffff7ba8000     0x7ffff7baa000     0x2000   0x1c4000 /lib/x86_64-linux-gnu/libc-2.23.so
      0x7ffff7baa000     0x7ffff7bae000     0x4000        0x0
      0x7ffff7bae000     0x7ffff7bd3000    0x25000        0x0 /lib/x86_64-linux-gnu/libtinfo.so.5.9
      0x7ffff7bd3000     0x7ffff7dd2000   0x1ff000    0x25000 /lib/x86_64-linux-gnu/libtinfo.so.5.9
      0x7ffff7dd2000     0x7ffff7dd6000     0x4000    0x24000 /lib/x86_64-linux-gnu/libtinfo.so.5.9
      0x7ffff7dd6000     0x7ffff7dd7000     0x1000    0x28000 /lib/x86_64-linux----Type <return> to continue, or q <return> to quit---
gnu/libtinfo.so.5.9
      0x7ffff7dd7000     0x7ffff7dfd000    0x26000        0x0 /lib/x86_64-linux-gnu/ld-2.23.so
      0x7ffff7ff0000     0x7ffff7ff3000     0x3000        0x0
      0x7ffff7ff6000     0x7ffff7ff8000     0x2000        0x0
      0x7ffff7ff8000     0x7ffff7ffa000     0x2000        0x0 [vvar]
      0x7ffff7ffa000     0x7ffff7ffc000     0x2000        0x0 [vdso]
      0x7ffff7ffc000     0x7ffff7ffd000     0x1000    0x25000 /lib/x86_64-linux-gnu/ld-2.23.so
      0x7ffff7ffd000     0x7ffff7ffe000     0x1000    0x26000 /lib/x86_64-linux-gnu/ld-2.23.so
      0x7ffff7ffe000     0x7ffff7fff000     0x1000        0x0
      0x7ffffffde000     0x7ffffffff000    0x21000        0x0 [stack]
  0xffffffffff600000 0xffffffffff601000     0x1000        0x0 [vsyscall]

### gdb: dump hex

via: https://stackoverflow.com/a/9234007/87207

requires `xxd`, which comes from `vim-common` on ubuntu.

(gdb) define xxd
>dump binary memory dump.bin $arg0 $arg0+$arg1
>shell xxd dump.bin
>end
(gdb) xxd &j 10
0000000: 0000 0000 0000 0000 0000 0000 4d8c a7f7  ............M...
0000010: ff7f 0000 0000 0000 0000 0000 c8d7 ffff  ................
0000020: ff7f 0000 0000 0000

raw lines:

define xxd
dump binary memory dump.bin $arg0 $arg0+$arg1
shell xxd dump.bin
end

### gdb: dump string

(gdb) x/s 0x403F9A
0x403f9a:       "%02X"

### gdb: dump bits

  - dump: `x/`
  - format bits: `t`
  - from: `$rax`
  - each element is a byte: `b`
  - eight times: `8`


(gdb) x/8tb $rax
0x614010:       00000000        01111000        00001000        00001000        01111000     00001000 00001000        00000000


other formats:

o - octal
x - hexadecimal
d - decimal
u - unsigned decimal
t - binary
f - floating point
a - address
c - char
s - string
i - instruction


other element sizes:

b - byte
h - halfword (16-bit value)
w - word (32-bit value)
g - giant word (64-bit value)

via: http://visualgdb.com/gdbreference/commands/x

### gdb: backtrace

(gdb) backtrace
#0  0x0000000000403d86 in ?? ()
#1  0x00007ffff7804830 in __libc_start_main (main=0x403d86, argc=1, argv=0x7fffffffed68, init=<optimized out>, fini=<optimized out>, rtld_fini=<optimized out>, stack_end=0x7fffffffed58) at ../csu/libc-start.c:291
#2  0x0000000000400b09 in ?? ()

### gdb: info frame

(gdb) info frame
Stack level 0, frame at 0x7fffffffec90:
 rip = 0x403d86; saved rip = 0x7ffff7804830
 called by frame at 0x7fffffffed50
 Arglist at 0x7fffffffec80, args:
 Locals at 0x7fffffffec80, Previous frame's sp is 0x7fffffffec90
 Saved registers:
  rip at 0x7fffffffec88
