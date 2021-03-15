# python debugger cheatsheet

* post-mortem debugging!
  end up in pdbpp/pdb on exception

    try:
      run_my_code()
    except:
      import pdb; pdb.set_trace()

* conditional breaks
  - break at function main(), only if num == 10
    b main, num == 10

* s(tep) 
  - step, steps in to functions, same as n if no function exists

* until( until next line number )
  - helps to get out of loops

* tbreak 
  - temp break

* disable 1 
  - disable break 1, but not delete it

* sticky
  - sticky print line numbers, may not be good when stepping line by line

* display x
  - display the value of x as we are stepping through code

* !
  - used to escape,  !c = 2
  - set c = 2
  - p c
    output: 2

* run x, y
  - if code support arguments, you can instruct pdb to re-run with different
    arguments

* commands 1 | breakpoint related
  - allows us to run multiple commands when breakpoint is hit
  - can be used like a print function in breakpoint
  - commands 1 ( enter commands for breakpoint 1 )

* condition 1 | breakpoint related
  - condition 1 (add conditions to breakpoint #1)
  - condition 1, x == 1 ( breakpoint valid only if x == 1 )

* pp locals()
  - prints local variables inside a dictionary
  - pp locals().keys() 
    - print keys

* debug
  - call any code, must step into it

  debug my_function()
  s(tep)

