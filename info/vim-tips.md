# useful things for [vim

Fri Mar 16 4:09:05 PM 2018

- increment letters and numbers

block select starting on second line, type g c-a

1
2
3
4

" increment letters too
set nrformats+=alpha

use ctr-o to go to last known files, use multiple times to cycle through them

- spelling
  set spell
  change word z= for suggestions
  zg to add word to dictionary

- gn
  start visual mode and select the next match
  use c-v to select multiple words, cgn, change what you need, hit . to repeat

- source vim file after making changes, does not require restarting vim

* :source %

- general vim tips

```
http://vim.wikia.com/wiki/Best_Vim_Tips#Really_useful
http://vim.wikia.com/wiki/Best_Vim_Tips
```

- use marks!!!

  - ma (marks a)

* mb ( marks b )

  - d'b (deletes until mark b)
  - 'a,'b!sort (sort between marks a and b)

  * redirect to file:
    Between lines with marks a and b (inclusive), append each line starting with "Error" to a file:

  - :'a,'b g/^Error/ .w >> errors.txt
  - :g/pattern/ .w! errors.txt (overwrite errors.txt, ! = create if needed)
  - :g/pattern/ .w! >> errors.txt (append errors.txt, ! = create if needed)

  * remove ^M characters from file

  * save copy of current file as extension.tmp
    :saveas %.tmp

  * Inside vi [in ESC mode] type: :%s/^M//g
    To enter ^M, type CTRL-V, then CTRL-M. That is, hold down the CTRL key then press V and M in succession.

  * case insensitive search, escape with \c

  - e.g: /\ctest == matches test and Test
  - use \C for capital match: e.g: /\Ctest == will match Test

  * execute macro on entire file or line range

  - :%normal @q
  - % == entire buffer
  - normal == execute normal command
  - @q == macro

  * execute @q number of times:

  - 99999@q

  * remove trailing on buffer for any line

  - %s/\s\+$//

  * the power of /g

  * copy line that match a patter to register a

  - :g/^x/y a

  * copy(append) lines that match a patter to register a

  - :g/^x/y A
  - :g/^x.\*/y A

  * remove from file and (append) lines that match a patter to register a

  - :g/^x/d A
  - :g/^x.\*/d A

  * clear register

* qbq ( clears b register using macro trick )

  - let @b = '' ( also clears registers )

  * copy registers

* let @b = @a (copy contents of reg a into b)

  - word boundary searches

  * :g/test\>/y b ( look for word ending in test and copy to b register )
  * :g/\<test\>/y b ( look for word "test" and copy to b register )

  - Display context (5 lines) for all occurrences of a pattern.

  * :g/pattern/z#.5
    " Same, but with some beautification.
  * :g/pattern/z#.5|echo "=========="

  - delete lines that do not match a pattern

  * :v/^x/d
  * g!/pattern/d

  - delete blank lines

  * :g/^\s\*$/d
  * :g/^\s\*$/d* (fast delete, use the * (black hole register))

  - Copy all lines matching a pattern to end of file.

  * :g/pattern/t$

  - Move all lines matching a pattern to end of file.

  * :g/pattern/m$

  - fast delete

  * :g/pattern/d* (* = black hole register, no action performed on match)

  - Run a macro on matching lines (example assuming a macro recorded as 'q'):

    - :g/pattern/normal @q

      - sort lines

      * :sort

      - delete duplicate lines and sort

      * :sort u

      - sort using patterns
        : sort /\a\a\a/ (sort by first 3 letters in line)

      * see help :sort for more examples

      - sort using external program:

      * :%!sort -k2r (field2 in reverse order)

      - sort csv using external program

      * %!sort -t 'ctrl-v tab' -k3 (ctrl-v tab inserts tab character, -k3 filters based on 3rd tab delimeter)
      * %!sort -t '=' -k1f ( sort by = as delimeter, by first appearance, -f flag ignores case sensetivity)

      - make columns tabular using external columns program

  * %!columns -t
  * 1,20!columns -t ( do it on a range line 1 to 20 )
  * ,20!columns -t ( do it on range from current line to 20 )

* ,$!columns -t (do it on range from current line to end of file)

  - https://jordanelver.co.uk/blog/2014/03/12/sorting-columnds-of-text-in-vim-using-sort/

  * change file encoding to utf8

  - set fileencoding=utf8
  - :w

  * join lines with g/ search

* g/^memberOf/j (joins lines that start with memberOf)

  - indent / re-indent entire document

  * G=gg

  - insert a range of numbers

  * :put range=(10,20) ( add a range of numbers between 10 and 20 )

  * :for i in range(1,10) | put ='192.168.0.'.i | endfor
    192.168.0.1
    192.168.0.2
    192.168.0.3
    192.168.0.4
    192.168.0.5

* select first list of numbers, ctrl-v, then hit g ctrol-A (this addes numbers to selection +1)

  - my_array[0] = 1;
  - my_array[0] = 2;
  - my_array[0] = 3;
  - my_array[0] = 4;
  - my_array[0] = 5;
  - my_array[0] = 6;

  - my_array[1] = 1;
  - my_array[2] = 2;
  - my_array[3] = 3;
  - my_array[4] = 4;
  - my_array[5] = 5;
  - my_array[6] = 6;

  * search and replace using very magic patterns | regex groups

  - %s/\v(\s+\d\d\d\s.\*)/#\1/g ( search for pattern, group and append
    #+group1 to the search )
  - 'm,'eg/\v^$/d (delete empty lines between mark m and e using very magic \v )

  * search very magic

  - /\v<the> ( find lines that have start with only the words '^the ' )

  * convert file to dos/unix format

  - :set ff=unix to convert to Unix; use :set ff=dos to convert to Windows

# Example for using a script file to change a name in several files:

- Create a file "subs.vim" containing substitute commands and a :update
  command: >
  :%s/Jones/Smith/g
  :%s/Allen/Peter/g
  :update

- Execute Vim on all files you want to change, and source the script for
  each argument: >

vim \*.let
]argdo source subs.vim
