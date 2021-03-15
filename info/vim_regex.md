# look arounds, vim look arounds affect the previous capture group only

```
  Positive lookahead: \@=
  Negative lookahead: \@!
  Positive lookbehind: \@<=
  Negative lookbehind: \@<!



regex removes blanks at end of line

    :\s*$:: (: is deliminator)

or (to avoid acting on all lines):

    s:\s\+$::)

delete blank lines:
   :g/^$/ d

reduce multiple blank lines to a single blank
    :g/^$/,/./-j
```

# non greedy matches and include new lines `\_`

```
    /\vdef\zs\_.{-}\zeend

```

this matches

```
def
  ... < matches
end
```
