### resources

`https://github.com/PacktPublishing/Network-Automation-with-Go.git`

### build with debug flags

`go build -gcflags='-N -l' -o myprogram main.go`

### debug with dlv

`dlv debug main.go`

- headless mode ( start debugging paused )

`dlv debug --headless --api-version=2 --listen=:2345`

`dlv connect :2345`

### set breakpoint

`break myfile.go:10`

### show code

`list main.go:10 (list code starting at line 10)`

### breakpoints

breakpoints - shows all breakpoints
clear 1 - clears breakpoint 1
clearall - deletes all breakpoints

### casting/converting

```go
body = []bytes

string(body) // converts byte array to a string
```

### print functions

```go

// always os.Stdout
fmt.Print]n(...interface{}) (int, error)
fmt.Printf(string, ...interface{}) (int, error)

// print to anything that has the correct Write() method
fmt.Fprint]n(io.Writer, ...interface{3) (int, error)
fmt. Fprintf(io.Writer, string, ...interface{}) (int, error)

// return a string
fmt.Sprintln(...interface{}) string
fmt.Sprintf(string, ...interface{}) string
```
