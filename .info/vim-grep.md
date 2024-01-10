https://dev.to/iggredible/vimgrep-tips-and-tricks-54pl


* `:vim /test/g **/*` search globally not just the first match
* `:vim /test/fg **/*` fuzzy search of the word test
* `:vim /test/g **/*.jw **/*.html` search in multiple places
* `:vim /test/g ##` search the arglist (all open files)

```sh
:vim /echo/g `find . -type f -name 'docker*'  # find files using external search tool
:vim /echo/g `git ls-files --modified` # search files that have been modified since last commit
:vim /echo/ **{sh,txt,md,html} # look in files that end with this extensions
:%g/\[/+1,/\]/-1sort  # sort a list [ 3, 4, 1, ] must be vertical, this takes 
# the list matches [ and applies a +1 offset (oneline) then matches the closing ]
# and applies a negative offset + sort command, which sorts the lines
``
