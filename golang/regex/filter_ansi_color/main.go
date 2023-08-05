package main

import (
	"fmt"
	"regexp"
)

func main() {
	str := "\x1b[31mHello\x1b[0m \x1b[32mWorld\x1b[0m"

	filteredStr := FilterANSIColor(str)
	fmt.Println(filteredStr)
}

func FilterANSIColor(str string) string {
	// Regular expression pattern to match ANSI escape sequences
	re := regexp.MustCompile(`\x1b\[[0-9;]*[a-zA-Z]`)

	// Remove ANSI escape sequences from the string
	filteredStr := re.ReplaceAllString(str, "")

	return filteredStr
}
