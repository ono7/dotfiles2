package main

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"net/url"
	"os"
	"strings"
)

// body: {"page":"words","input":"","words":["word1","word2","word3"]}

type Words struct {
	Page  string   `json:"page"` // extract fields from json for use in struct values
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
	if response.StatusCode != 200 {
		log.Fatal("Wrong status code: ", response.StatusCode)
	}

	var words Words
	err = json.Unmarshal(r, &words) // view signature to figure out what this returns and that it needs a pointer
	if err != nil {
		log.Fatal(err)
	}

	fmt.Printf("Page: %s, Words -> %s", words.Page, strings.Join(words.Words, ", "))

}
