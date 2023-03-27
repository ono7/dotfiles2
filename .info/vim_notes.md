## grep/rg inside vim, use single quotes to pass regex and escape | with \|

https://pabloariasal.github.io/2020/04/25/vim-is-for-the-lazy/

`:grep -i -g "*.cpp" -g "*.h" 'mock_method\d+'`

If you use GNU grep, you have to explicitly provide the files to be searched:

`:grep -i 'mock_method\d+' **/*.cpp **/*.h`

searching regex, just needs to escape | with \|, this allowes regular regex to work inside vim!

using ripgrep:

`:grep '100.\d{1,3}\.\d{1,3}\.\d{1,3}'`



## other notes
  -- TODO (jlima) : 07-02-2021 | https://youtu.be/XA2WjJbmmoM

  NOTES:

  :ls -> list buffer
  :b ini -> opens init.vim, just need to type part of the buffer name
  :find *dark.lua -> onedark.lua (recursively searches for files, use regex for fuzzy find)
  c^ switch to last file edited
  gi -> last insert text position
  vimgrep /regex/j **/*.lua -> search in all lua files, j = dont open (quickfix)
  prefix any fzf with single quote for exact match!!  Rg> '<c-n>
  > finds only lines containing <c-n>

  negative lookahead

  \v---(.* ---)@!

  finds all occurances of --- that do not end with ---

  positive look ahead

  \v---(.*bit ---)@=

  finds all occurances of --- that end with "bit ----"

--]]
