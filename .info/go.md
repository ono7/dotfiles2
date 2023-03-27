# macos 07/23/22

# go program flags

when using "flag" package:

strings can be called `./goprog -name "jose"`

bool can be set to true by simply calling the flag

`./goprog -debug -preview`

this would set the debug and preview flag to true


# go notes

- path ~/go/bin added via PATHS (zshrc)
- every go file must have a package declaration
- go does not require a runtime like java or python, its a compiled language
- inline code is allowed with `;`
- log.Fatal(err) prints err and exits(1)

```go
// define vars and test inline
// variables defined this way, are only avaliable within that context, in this case
// this is only valid within the if statement
if _, err := url.ParseRequestURI(args[1]); err != nil {
fmt.Println("url is in invalid format: %v\n", err)
  log.Fatal(err)
}
```

## Abbreviations

```go
// look at the go standard library for more
var s string       // string
var i int          // index
var num int        // number
var msg strings    // message
var v string       // value
var fv string      // flag value
var err error      // error value
var args [] string // arguments
var seen bool      // has seen?
var parsed bool    // paaarsing ok
var buf [byte]     //buffer
var off int        // offset
var op int         // operation
var opRead int     // read operation
var l int          // length
var n int          // number or number of
var m int          // another number
var c int          // character
var a int          // array
var r rune         // rune
var sep string     // separator
var src int        // source
var dst int        //destination
var b byte         // byte
var b []byte       // buffer
var w io.Writer    // writer
var r io.Reader    // reader
var pos int        // position
```

its ok to use longer names in package level scope

```go
package main

var testAPI string

// API is an Abbreviation so you want to capitalize it and not do testApi here
```

- dont stutter

`player.PlayerScore` - stutter, players is successive, use `player.score` instead

- constants

`const MAX_TIME int` - dont do this,
`const MaxTime int` - this is preffered for constants
`const N int` - this is also ok

## interfaces

- an interface is a "protocol" it only describes the expected behaviour, has no logic
- as long as anything that is part of the interface satisfis what it describes,
  it can be that interface. if an interface requires two methods Draw() and
  Power(), then all members of that interface, should have these two methods
- a set of related objects or types

## types

Types can be:

- Elementary (or primitive): int, float, bool, string,
- Structured (or composite): struct, array, slice, map, channel,
- Interfaces only describe the behavior of a type.

```go
type (
  IZ int
  FZ float
  STR string
)
```

int = 1
float64 = 2.1
string = "test"

- you cant use values that belong to different types together e.g.

```go
num := 1
flt := 2.4

speed = flt * num  // error

//solution, cast the types back and forth
speed := 100
force := 2.5
// speed = speed * force invalid operation
// cat the speed int to float64
speed = int(float64(speed) * force)
fmt.Println("float times int, must cast int to float and back: ", speed)

```

`...any` - any type
`strings` - string
`[]string` - a struct of strings = \[ "ab", "cd", "ef", "gh" \]
`[]string` - a struct of ints = \[ 1, 2, 3, 4, 5, 6, 7, 8, 9, 0 \]

## running servers/files

- start all go files if main.go is split into mulitple

`go run *.go`
Starting server on port 8080...

- if program only needs main.go to start
  `go run main.go`

## printing

Println - print a line with new line
Printf - allows formatting the string

## go language reference guide

- ref: https://www.includehelp.com/golang/builtin-package.aspx

# packages/package

```go
// different ways to import
import "fmt"
import ("fmt"; "otherpkg")
import (
  "fmt"
  "otherpkg"
)
```

## installing third party modules/packages

```sh
🐇 go get -u github.com/eiannone/keyboard
go: downloading github.com/eiannone/keyboard v0.0.0-20220611211555-0d226195f203
go: downloading golang.org/x/sys v0.0.0-20220520151302-bc2c85ada10a
go: downloading golang.org/x/sys v0.0.0-20220727055044-e65921a090b8
go: added github.com/eiannone/keyboard v0.0.0-20220611211555-0d226195f203
go: added golang.org/x/sys v0.0.0-20220727055044-e65921a090b8
```

## building packages

go build -o eliza main.go

## make(map\[int\]string)

maps , use make to create one, map\[int\]string
creates a map of integers with string values

## go variables

- if you dont know the initial value, use shor declaration `score := 0`, use `var score int`

- at the package scope level, you can only use normal declarations `var score int`

- multi-var declarations

  ```go
  var (
    video string
    duration int
    current int
  )
  ```

- use `_` to discard variables when unpacking

- variables must begin with a letter or underscore

  - upper case, make it public (this applies to packages)
  - lower case, its private

- constants dont have to be capital letters here

- GLOBALS are defined outside of the main function and are avaliable to any other function below

```go
const prompt = "and press ENTER when ready.."
```

- you can declare two or more variables at the same time in one line

```go
var output, remainder, test string
```

### type conversions

change the type of a variable to another type

## go regexp (module)

```go
import "regexp"

reg, err := regexp.Compile("[^a-z-A-Z0-9]+")
if err != nil {
  log.Fatal(err)
}
userInput = reg.ReplaceAllString(userInput, " ") // replace with spaces
```

## go for loop

```go
for i := 0; i < len(notes); i++ {
  fmt.Println(i)
  // continue -- exits this iteration but continues the loop
  // break -- exits the loop
}
```

## go comments and strings

- join array of strings

```go
import strings
// response == [ "test", "test2", "test3" ]
fmt.Printf("resp: %v", strings.Join(response, ", ")
// output -> "resp: test, test2, test3"
```

- comments
  - when commenting functions, make the first word the same as the function name

```go
// myIntro returns a multiline string
func myIntro() string {
	return `this is a multiline string
	that is returned
	....`
}
```

- string slices

```go
	words := strings.Fields( // words becomes a slice [] aka list in python
		"lazy cat jumps again and again and again",
	)
```

## go dap - debug adapter (dlv)

`go install github.com/go-delve/delve/cmd/dlv@latest`

~/dev/golang/udemy/

## go commands

### go modules

- initialize a new app, creates a go.mod file
  `go mod init appname`

```text
🥷 go mod init myapp
go: creating new go.mod: module myapp
go: to add module requirements and sums:
go mod tidy
```

```go
import "myapp/mymodule"
```

## go core components

- dynamic typing

```go
a := "test" //dynamically assigns "test" to var a, and type as string
b := 1 //dynamically assigns 1 to var a, and type as int

// or

var a string
a = "test"
```

# functions

- passing values to functions, copies the data into a local variable for the function, this is why
  pointers maybe necessary to interact with passed values into a function call

- small functions can be written in one line

`func Sum(a, b int) int { return a + b }`

- The same rule applies wherever { } are used (for example: if, etc.).

```go
func change(data collection) {
  // var data collection
  // local data = passed data value
  data[2] = "brilliant!"
  fmt.Println(collection)  // prints only the locally modified values inside this scope
  // use pointers to modify the original passed data
}

```

```go
func myFunc() string {}  // declare a function that takes no parameters and returns a string
```

- loops

* there is only one kind of loop in go, the for loop
* use break to exit out of the loop

```go
for {
	fmt.Print("input --> ")
	userInput, _ =  := reader.ReadString('\n')
	response = := doctor.Response(userInput)
	if userInput == "quit" {
		break
	} else {
	//
	}
	fmt.Println(response)
}
```

## go seed rand

```go
import ("time", "math/rand")
rand.Seed(time.Now().UnixNano()) //nano changes more frequently and provides a better rand generator
```

# golang structs

```go
// {"page":"words","input":"","words":[]}
type Words struct {
	Page  string
	Input string
	Words []string // array of strings
}
```

## strings

- concatenation is supported with + , e.g. `"h" + "e" + "y"" -> "hey"`
- string literal is double backticks \`this is a string literal\`
- use unicode/utf8 package to count runes, characters that are not english `utf8.RuneCountInString("long string with chars")`
- use "strings" package to repeat, upper, lower etc

```go
s := "regular string literal" // interpolated
s := `string leteral`
s := `multiline
string literal` // nothing interpreted/interpolated
```

- len(), can only find regular letters, not non-english letters.
- runes are made up of bytes, each characters can be 1 byte or groups of bytes, special utf chars take 2 bytes

## string interpolation

- use type safe verbs intead of `%v` where possible, this will lower any errors due to wrong type being used

  `%T` -> type of variable
  `%s` -> string
  `%d` -> numbers
  `%f` -> float (see pressision below)
  `%0f` -> 224.121 -> 224
  `%1f` -> 224.121 -> 224.1
  `%2f` -> 224.121 -> 224.12
  `%3f` -> 224.121 -> 224.121
  `%t` -> bool
  `%v` -> let go figure out what the variable is

## Atoi - ASCII to integer

- converts ascii characters to their integer representation

## Itoa - Integer to ASCII

- converts integers to their ascii representation

## flow if else if

```go
func main() {
	score := 3
	if score > 3 {
		fmt.Println("score is greater than 3")
	} else if score == 3 {
		fmt.Println("score is equal to 3")
	} else if score == 2 {
		fmt.Println("score is meh (2)")
	} else {
		fmt.Println("score is less than 3")
	}
}
```

## nil

means that the value is not initialized yet

## errors

- when a function returns an err value, you should always handle it
- when there is an error, never use the rest of the return values from a
  function, except the error value it self

## case/switch

- switch statements get converted to if statements in go automatically
- switch is syntax sugar
- variable scope, vars are only avaliable inside each "case" block

```go
import "fmt"

func main() {
	city := os.Args[1]
	switch city {
	case "Paris":
		fmt.Println("France")
    v := "test, only avaliable inside here"
    fmt.Println(v)
	case "Tokyo":
    fmt.Println("Japan")
  default: // can live any where in the switch statement, order not important
    fmt.Println("this is the default clause")
  }
}
```

- the type of the switch condition should matcht the case

```go
switch true {  // switch type is bool
  case i > 0 { // case condition test is bool
    fmt.Println("I is greater than Zero")
  }
}
```

# data structures arrays, slices, string, maps, structs

- arrays

  - collection of elements, indexable and fixed lenght
  - comparing arrays can be done when:
    - the type is the same
    - array elements must be equal, they are compared one at a time
  - the length of the arrays are inseparable from its type `[3]int{1,2,3}`, [3]int is the type

  - arrays in go are value types not referens types, this
    means that when an array is assigned to a new variable
    a copy of the original is assigned to the variable

  - arrays when passed to functions are also passed by
    value which means they are copied and the original is
    not changed this is why its important to know when to
    use pointers and dereferencing

  e.g.

  ```go
  a = [...]int{1,2,3,4}
  b := a // all elements are COPIED into a NEW array
  ```

  ```go
  printing arrays

  var books [4]string
  books[1] = "this is a test"
  books[2] = "this is a test 2"
  fmt.Printf("books : %q\n", books)
  // print in quotes -> books : ["" "this is a test" "this is a test 2" ""]
  fmt.Printf("books : %#v\n", books)
  // prints array type and elements together -> books : [4]string{"", "this is a test", "this is a test 2", ""}
  ```

  ```go
  // multidymentional arrays

  [2][3]int{
    [3]int{1,2,3}
    [3]int{4,5,6}
  }  // 2 int arrays of len 3

  // OR

  [2][3]int {
    {1,2,3}
    {4,5,6}
  } // samething, but shorter

  ```

* keyed elements

- why not use a hash instead?

```go
const (
  ETH = iota // -> 0
  WAN // -> 1
)

rates := [3]float64{
  WAN: 120.2,
  ETH: 1.5,
} // --> [1.5, 120.2]
// order does not matter when using keyed elements
```

# unnamed types

```go
[3]int{6, 9, 3}

type bookcase [3]int
type cabinet [3]int

bookcase{6, 7, 8} == cabinet{6, 7, 7} // does not work, because a named type is different than other name types

// you can convert types and compare

bookcase{6, 7, 8} == bookcaste(
  cabinet{6, 7, 7}
) // this would work now that they are the same type
// you can only convert them if their underlying types are identical
```

# arrays vs slices

- go is statically typed, meaning arrays cannot grow at run time, they are static `[2]int`
- slice can change and its declared with out a fixed length `[]int`, **length is not part of its type**
- slices and arrays both must contain the same type of elelements
- slices can be initialized so they are not `nil`, `[]int{}`, this initiliazes an int slice! and its no longer nil
- **NEVER** check wether a slice is nil or not, always check the _length_ of a slice instead
  - if a slice is empty the lenght will aways be 0
- slice values are stored in a `backing` array in memory that can be shared, pointers?

# append (slices)

- `append(sliceName, 1, 2)` -- returns a new slice with the new values appended
- slices grow in size when allocating new elements, they grow dynamically by copying the contents
  of the previous slice to a "new" backend array, this can be costly but wont be noticed for a long time
- when the backing array requires optimization, use make command to improve performance

```go
s := make([]int, 3, 20)
// creates an backend array with len of 3 and cap of 20, useful to preallocate cap so slice
// does not keep copying and destroying slices

```

```go
numbs := []int{1,2,3}
append(numbs, 1,2,3) // --> []int{1,2,3,1,2,3}

x := []int{1,2,3}
y := []int{4,5,6}

append(x, y...) // --> []int{1,2,3,4,5,6}, ellipses appends all elements of y to x and returns new slice
```

# data types

- slices

  - collection of elements indexable and dynamic in lenght

- string internals

  - byte slices ascii & unicode used for encoding and decoding

- maps

  - collection of indexable key-value pairs

- struts

  - groups of different types of variables together

# standard libray

sort - used to sort slice

# pagination (slices)

```go
func main() {
	msg := []byte{'h', 'e', 'l', 'l', 'o', 'A', 'B', 'C', 'D', 'F', 'G', 'H', 'I', 'J', 'K'}

	l := len(msg)

	const pageSize = 4

	for from := 0; from < l; from += pageSize {
		to := from + pageSize
		if to > l { // check if we are out of bounds or set to limit len(msg)
			to = l
		}
		currentPage := msg[from:to]
    fmt.Println("Page ->> ", len(currentPage))
		fmt.Println(currentPage)
	}
}
```

# encoding and decoding

- strings are bytes
  they can be interchangable

  ```go
  name := "jose"
  fmt.Println(byte(name))
  ```

  - runes: are unicode code-points, they are simply called runes in Golang
    `104 = h` , 104 is the rune in go

    - rune literals are the actual characters `104 = h`, h is the rune leteral
