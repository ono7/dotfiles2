# creating go modules

```sh
# folder structure for an app
myapp
├── Makefile
├── README.md
├── go.mod
├── main.go
├── types
│   └── users.go
└── utils
    └── get.go
```

1. create a directory (this name is used by go mod init xyz)
   the name must match for resolution to work correctly
   `mkdir myapp`
2. create a main.go
   `cd myapp`
   `vim main.go`
3. `go mod init myapp`

4. create other modules

`mkdir utils`
`cd utils`
`vim utils.go`

```go
// utils.go
package utils

// code goes here
```

5. in main.go import utils with

```go
package main

import "myapp/utils"
```

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
