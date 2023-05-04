# build with debug flags

`go build -gcflags='-N -l' -o myprogram main.go`

# debug with dlv

`dlv debug main.go`

# set breakpoint

`break myfile.go:10`

#  show code

`list main.go:10  (list code starting at line 10)`
