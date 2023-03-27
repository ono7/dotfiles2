++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+                            vimscript the hardway                             +
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

refs:
http://learnvimscriptthehardway.stevelosh.com


++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+                               printing/echoing                               +
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

* echom saves command output and you can  view the messages using :messages,
  useful for debugging if you want to save the output of a command for later viewing



++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+                                  variables                                   +
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


# l:number = var number is local
# a:number = argument scope, this tells vim that this is an argumnet
  -  useful in functions. e.g. PrintName(name), echom a:name
# b:number = var number is local to the buffer
#
# g:number = var number is global (avaliable everywhere)

# s: current script's namespace


++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+                             if/elseif/else/endif                             +
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

```vim
if 0
    echom "if"
elseif "nope!"
    echom "elseif"
else
    echom "finally!"
endif
```


++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+                  critical case sensitive knowledge here...                   +
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

==? ( case sensive comparision )

this is broken if we :set ignorecase
==# ( case sensitive no matter what the user has set comparision )

```vim
" this will test true
if "foo" == "FOO"
  echo test
endif

" this will test false, because ==? means case sensitive...always use ==? if you
" need a case sensitive comparision
if "foo" ==? "FOO"
  echo test
endif
```



++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+                                 functions()                                  +
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

http://learnvimscriptthehardway.stevelosh.com/chapters/24.html

define functions with:

```vim
function! Function()

endfuntion
```

# functions can take variable-length  argument lists like python

```vim
function Vargs(...)
  echom a:0
  echom a:1
  echo a:000
endfuntion
```

:call Vargs("a", "b")

# a:000 - when using lists arguments, a:000 will contain all the extra arguments that were passed
# a:0 has the number of arguments in the list  [ 'a', 'b', 'c' ], a:0 will display 3

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+                                             numbers                                              +
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

http://learnvimscriptthehardway.stevelosh.com/chapters/25.html

:echom 100 - decimal, vanilla decimal
:echom 0xff - hex, prepend with 0x displays 255
:echo 010 - octal, prepend with 0

* when using floats, do not use echom, use echo

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+                                             strings                                              +
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

http://learnvimscriptthehardway.stevelosh.com/chapters/26.html

# vim's + operator is only used for numbers, use . to concatenate strings

this is valid however, echom "3 test " + "2 test" , vim echoes 5, as long as the number is first

* concatenate with "."

echom "test " . " test2" = test test2

# escape sequences with \, echom "foo\\bar" = foo\bar

echom "foo\nbar" = error
echo "foo\nbar" = foo
                  bar

# single quotes, basically tells vim to use the string RAW , literal string
# double quotes will interpret "\n" as new line, while '\n' will be literal

* one execption, two single quotes in a row will produce one single quote

'thats''s enough.'

# escape strings when passed to normal!  using expand()

```vim
:nnoremap <leader>g :execute "grep -R " . expand("<cWORD>") . " ."<cr>

```
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+                                        string functions()                                        +
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

http://learnvimscriptthehardway.stevelosh.com/chapters/27.html


measure length

# strlen() - measure string length
strlen("foo")

# len() - measure length
len("foo")

# split() - split string to list
'echo' split("this is a huge test") = ['this', 'is', 'a', 'huge', 'test']

# join() - join with spaces by default join([], "\.") join with .
  join(['this', 'is', 'a', 'huge', 'test'], ",") = this,is,a,huge,test
  second argument to a separator is the delimter to use, in this case "," default is space

# toupper() - cap all

# tolower() - lower case all

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+                                              normal                                              +
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

http://learnvimscriptthehardway.stevelosh.com/chapters/29.html


normal takes into account any mapping that exists

:nnoremap G dd - G now delete a single line
:normal G  - deletes line

* use :normal! to avoid mapping issues, that way :normal! G, will go to the bottom of the screen like
its supposed to.

normal does not parse special character sequences
```vim
:normal! /foo<cr> " this would not work
```

# to fix this use execute

```vim

execute "normal! /foo<cr>"
" execute will evaluate all the parameters first including <cr> special sequences"

```

# escape strings when passed to normal!  using expand(), this will expand the
# cWORD ( under the cursor )

```vim
:nnoremap <leader>g :execute "grep -R " . expand("<cWORD>") . " ."<cr>

```



++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+                                       regular expressions                                        +
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

http://learnvimscriptthehardway.stevelosh.com/chapters/31.html


++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+                             shellescape/expand                               +
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

http://learnvimscriptthehardway.stevelosh.com/chapters/32.html



++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+                          visual selectoin functions                          +
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

http://learnvimscriptthehardway.stevelosh.com/chapters/33.html

  ```vim
  nnoremap <leader>g :set operatorfunc=GrepOperator<cr>g@
  vnoremap <leader>g :<c-u>call GrepOperator(visualmode())<cr>

  function! GrepOperator(type)
      if a:type ==# 'v'
          execute "normal! `<v`>y"
      elseif a:type ==# 'char'
          execute "normal! `[v`]y"
      else
          return
      endif

      echom @@
  endfunction
  ```

visualmode(), returns "v" for character type visual, V for line visual, Ctrl-v
for block visual mode

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+                                 vim lists []                                 +
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


* list can be concatenated with +  [ 'test', 'test2' ] + [ 'test3', 'test4' ]
  is: [ 'test', 'test2', 'test3', 'test4' ]


# add()
  * add elements to a list
  ```vim
  let foo = ['a']
  call add(foo, 'b') " adds 'b' to list foo, echoes ['a', 'b']
  echo foo
  len(foo) " displays 2
  ```

# index()
  * returns the index number for the given list
  ```vim

  echo index(foo, 'b')
  ```

# join()

  ```vim
  echo join(foo)
  echo join(foo, '---')

  echo join([1, 2, 3], '')
  " joins the list, with no spaces!
  ```

# reverse()
  reverse the list, in place
  ```vim
  call reverse(foo)
  echo foo
  [ 'b', 'a' ]
  ```


