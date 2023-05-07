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

type Page struct {
	Name string `json:"name"`
	Page string `json:"page"` // extract fields from json for use in struct values
}

type Words struct {
	Input string   `json:"input"`
	Words []string `json:"words"`
}

type Occurrence struct {
	Words map[string]int `json:"words"`
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

	var page Page
	err = json.Unmarshal(r, &page) // view signature to figure out what this returns and that it needs a pointer
	if err != nil {
		log.Fatal(err)
	}

	switch page.Name {
	case "words":
		var words Words
		err = json.Unmarshal(r, &words) // view signature to figure out what this returns and that it needs a pointer
		if err != nil {
			log.Fatal(err)
		}
		fmt.Printf("Page: %s, Words: %s", page.Name, strings.Join(words.Words, ", "))
	case "occurrance":
		var occurrance Occurrence
		err = json.Unmarshal(r, &occurrance) // view signature to figure out what this returns and that it needs a pointer
		if err != nil {
			log.Fatal(err)
		}
		for word, occurrance := range occurrance.Words {
			fmt.Printf("%s, %d", word, occurrance)
		}
	default:
		fmt.Printf("Page not found\n")
	}

}
