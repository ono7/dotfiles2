package main

import (
	"fmt"
	"regexp"
)

func main() {
	x := `
	% error:  this is the first error
	% error:  this is the second error
	% error:  this is the third error
	% error:  this is the fourth error
	`

	er := regexp.MustCompile(`% error: .*`)
	fmt.Println(er.MatchString(x))
	fmt.Println(er.FindString(x)) // returns only the first error
}
