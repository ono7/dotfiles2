# notes

- ctrl-r works to search for old commands
- install: `go install github.com/go-delve/delve/cmd/dlv@latest`

# video reference

`https://www.youtube.com/watch?v=qFf2PRSfBlQ&t`

# execute in debugger

`dlv exec ./main`

# set break point on function/method

break Rectangle.Area

```go
// finds this method and sets a breakpoint
func (r *Rectangle) Area() {}

```
