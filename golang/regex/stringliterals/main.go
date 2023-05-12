package main

import (
	"fmt"
	"regexp"
	"strings"
	// "strings"
)

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

	var newString []string

	for _, v := range cliErrors {
		newString = append(newString, regexp.QuoteMeta(v))
	}

	newRegexOr := strings.Join(newString, "|")

	reErrors := regexp.MustCompile(newRegexOr)

	fmt.Println(newRegexOr)

	fmt.Println(reErrors.MatchString(fakeErr))

}
