## io.Reader (implement reader)

- io.ReadAll, will read from anything that implements Reader

read data from anything

```go
package main

import (
	"fmt"
	"io"
	"os"
)

func main() {
	f, err := os.Open("book.txt")
	if err != nil {
		panic(err)
	}
	defer f.Close()
	readerToStdout(f, 128)
}

func readerToStdout(r io.Reader, bufSize int) {
	buf := make([]byte, bufSize)
	for {
		n, err := r.Read(buf)
		if err == io.EOF {
			break
		}
		if err != nil {
			fmt.Println(err)
			break
		}
		if n > 0 {
			fmt.Println(string(buf[:n]))
		}
	}

}

```

## use bytes.Buffer to implement Writer and Reader interface

```go
package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"os"
)

type user struct {
	First string `json:"first"`
	Last  string `json:"last"`
	Age   int    `json:"age"`
}

func main() {
	f, err := os.OpenFile("file.txt", os.O_WRONLY|os.O_CREATE|os.O_TRUNC, 0600)
	if err != nil {
		panic(err)
	}
	defer f.Close()
	buf := new(bytes.Buffer)
	enc := json.NewEncoder(buf)
	u := user{
		First: "jose",
		Last:  "lima",
		Age:   45,
	}
	if err := enc.Encode(u); err != nil {
		panic(err)
	}
	fmt.Println(buf.String())
}
```
