package main

import (
	"fmt"
	"regexp"
	"strings"
	// "strings"
)

// escape and format string slice for use with re 'or' operator
func reEscape(s []string) string {

	var newString []string

	for _, v := range s {
		newString = append(newString, regexp.QuoteMeta(v))
	}

	return strings.Join(newString, "|")

}

func main() {
	fakeErr := `
		% invalid markr detected
		bad things | (y/n) [yes/no]
	`
	cliErrors := []string{
		`% invalid marker`,
		`bad error (% xyz)`,
		`bad things | (y/n) [yes/no]`,
	}

	reErrors := regexp.MustCompile(reEscape(cliErrors))
	print(reEscape(cliErrors))
	fmt.Println(reErrors.MatchString(fakeErr))

}
