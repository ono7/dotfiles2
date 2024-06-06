# notes

- ctrl-r works to search for old commands
- install: `go install github.com/go-delve/delve/cmd/dlv@latest`

# video reference

`https://www.youtube.com/watch?v=qFf2PRSfBlQ&t`

# execute in debugger

`dlv exec ./main`

## set break point on function/method

Set breakpoints and execute expressions when we hit them

```go
break Rectangle.Area
// execute code when hitting breakpoints

on 1 print a // when breakpoint 1 hits, print the a variable
on 1 -edit // allows for easier editing using editor
```

source debugger instructions from source file

```go
// debug_config.txt
// break main.go:28
// on main.print a
// break main.go:37

source debug_config.txt

```

## clear breakpoints

- clear 1 - clears breakpoint 1
- clearall - clears all breakpoints

```go
// finds this method and sets a breakpoint
func (r *Rectangle) Area() {}

```
