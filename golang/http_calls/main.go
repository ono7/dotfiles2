package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
	"net/url"
	"os"
)

// body: {"page":"words","input":"","words":["word1","word2","word3"]}

type words struct {
	Page  string   `json:"page"`
	Input string   `json:"input"`
	Words []string `json:"words"`
}

func main() {
	args := os.Args
	if len(args) < 2 {
		fmt.Printf("Usage: ./http.get <url>\n")
		os.Exit(1)
	}

	_, err := url.ParseRequestURI(args[1])
	if err != nil {
		log.Fatal(err)
	}

	response, err := http.Get(args[1])
	if err != nil {
		log.Fatal(err)
	}
	defer response.Body.Close()
	r, err := io.ReadAll(response.Body)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("Status: %d\n\n", response.StatusCode)
	fmt.Printf("body: %s\n", string(r))
}
