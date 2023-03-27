### ollydbg: Functions start with: PUSH EBP – MOV EBP, ESP, end with RET


### ollydbg: keys
F2 = breakpoint
F7,F8 = step into, step around

F9 = run until next break

### ollydbg: find command sequence (use r32 as register variable)

POP r32
POP r32
RETN

check Entire Block , r32 means any r32 register


### ollydbg: binary edit ctrl-e
edit existing binary bytes instead of using str based instruction
