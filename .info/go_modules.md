# module information

## installing go modules

```
go install github.com/
```

- path
  `path.Split() -> dir, file`

  ```go
  dir, file = path.Split("/etc/config/test.cfg")
  // dir = /etc/config/
  // file = test.cfg
  ```

- os
  - user input

- iota - constant number generator, increases number for each constant defined

```go
	const (
		monday  = iota // = 0
		tuesday        // = 1
		wednesday      // = 2
		thursday       // = 2
		friday         // = 2
		saturday       // = 2
		sunday         // = 2
	)
```
