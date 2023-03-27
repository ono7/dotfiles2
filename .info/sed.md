# sed

substitute first line in file (requires GNU sed)

`for i in $( ls * ); do sed -i '1 s/^/This is my first line\n/' $i; done`

# subsitute in different files recursively using ripgrep (rg)

rg 'mypattern' -l | xargs sed -i 's/thispattern/newpattern/g'
