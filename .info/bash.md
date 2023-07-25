`${var:=value}` - Use var if set; otherwise, use value and assign value to var.

`${var:?value}` - Use var if set; otherwise, print value and exit (if not
interactive). If value isn’t supplied, print the phrase parameter null or not set to stderr. 

`${var:+value}` - Use value if var is set; otherwise, use nothing.

`${#var}` - Use the length of var. 

`${#*}` - , 

`${#@}` - Use the number of positional parameters. 

`${var#pattern}` - Use value of var after removing text matching pattern
from the left. Remove the shortest matching piece. 

`${var##pattern}` - Same as #pattern, but remove the longest matching piece. 

`${var%pattern}` - Use value of var after removing text matching pattern from the
right. Remove the shortest matching piece. 

`${var%%pattern}` - Same as %pattern, but remove the longest matching piece. 

`${var^pattern}` - Convert the case of var to uppercase. The pattern is
evaluated as for filename matching. If the first letter of var’s value matches
the pattern, it is converted to uppercase. var can be * or @, in which case the
positional parameters are modified. var can also be an array subscripted by * or
@, in which case the substitution is applied to all the elements of the array.
