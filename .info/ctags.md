# create tags for current folder

ctags -R -f ~/.tags .

# vim C-t (set to generate tabs)

- this generates tags for the current folder recursively
  the tags are referenced in vim config and point to ~/.tags!
  this means everytime we run this c-t command, this tags file is
  overwritten with a new one, but keeps the config out of the directory's way

# vim ctags

https://andrew.stwrt.ca/posts/vim-ctags/

# find files and create ctags for them

`find . -name \*.java -exec ctags -R ./.tags --append {} \;`
