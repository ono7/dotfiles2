package main

import (
	"fmt"
	"io"
	"log"
)

type MySlowReader struct {
	Contents string
}

func (m MySlowReader) Read(p []byte) (n int, err error) {
	return 0, io.EOF
}

func main() {

	mySlowReaderInstance := MySlowReader{
		Contents: "test",
	}

	out, err := io.ReadAll(mySlowReaderInstance)

	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("output: %s\n", out)
}
