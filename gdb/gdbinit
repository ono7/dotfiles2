################################################################################
#                              display by default                              #
################################################################################

# decent default view, when there is nothing else to use
# values are in little-endian format so eax will be display on top eve though it
# is defined at the bottom.  

# you can also add address or other things that should be display every time we
# run, in this case i want to monitor 0x8049108 an initialized variable called
# sample in a program

# display/8b 0x8049108
# display/x $esp
# display/x $edx
# display/x $ecx
# display/x $ebx
# display/x $eax

# define hook-stop
#   disassemble $eip,+10
# end

# clear some of the displays with delete display line_no

# Dump of assembler code from 0x80480ba to 0x80480ca:
# => 0x080480ba <_start+58>:      mov    bx,WORD PTR ds:0x8049108
#    0x080480c1 <_start+65>:      mov    ecx,DWORD PTR ds:0x8049108
#    0x080480c7 <_start+71>:      mov    eax,0x33445566
# End of assembler dump.
# 0x080480ba in _start ()
# 9: x/8xb 0x8049108
# 0x8049108:      0xaa    0xbb    0xcc    0xdd    0xee    0xff    0x11    0x22
# 5: /x $eax = 0xbbaa
# 4: /x $ebx = 0x0
# 3: /x $ecx = 0x0
# 2: /x $edx = 0x0
# 1: /x $esp = 0xbffffcc0
# gdb-peda$

################################################################################
#                                     peda                                     #
################################################################################

# **** works with older version of GDB...

# a little help for gdb
# https://github.com/longld/peda
# git clone https://github.com/longld/peda.git ~/peda
# echo "source ~/peda/peda.py" >> ~/.gdbinit
# echo "DONE! debug your program with gdb and enjoy"


# change peda/lib/config.py
# -    "debug"     : ("off", "show detail error of peda commands, e.g: on|off"),
# +    "debug"     : ("on", "show detail error of peda commands, e.g: on|off"),

################################################################################
#                                     GEF                                      #
################################################################################

# **** works with newer versions of gdb but, its OS agnostic

# wget -O ~/.gdbinit-gef.py -q https://github.com/hugsy/gef/raw/master/gef.py
# echo source ~/.gdbinit-gef.py >> ~/.gdbinit

################################################################################
#                                  shortcuts                                   #
################################################################################

# r = run

# st _start | run my window layout, break @ _start and run

# si - Execute one machine instruction, then stop and return to the debugger.

# ni - Execute one machine instruction, but if it is a function call, proceed
#   until the function returns.



################################################################################
#                                   settings                                   #
################################################################################


# turn this things off
set verbose off
set confirm off

# other defaults
set output-radix 0x10
set input-radix 0x10
set print pretty on
set print array off
set print array-indexes on
set history filename ~/.gdb_history
set history size 32768
set history expansion on
set history save


#intel flavor
set disassembly-flavor intel

set disable-randomization on

set tui border-kind ascii
set tui active-border-mode half

# different prompt
set prompt gdb$

# never pause!
set height 0
set width 0

################################################################################
#                                 my functions                                 #
################################################################################
def rr
  context_register
  context_code
end

def st
# setup my window layout and break point by calling
# st main | st _start
  break $arg0
  run
  dont-repeat
  layout asm
  winheight ASM 7
  winheight CMD 3
  tui reg general
end

def normal
  winheight CMD 15
end

################################################################################
#                                   run last                                   #
################################################################################

# disable pagination at the end
set pagination off


################################################################################
#                                    notes                                     #
################################################################################

# CentOS, keep tui from breaking
# gdb -x cmd_file -tui target_file

source ~/peda/peda.py
# source ~/gef.py
