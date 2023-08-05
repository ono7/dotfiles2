# working with json data

## parsing unknown data

```go
// user interface{} as the value since we dont know what is comming in
// key will always be string
// var testdata map[string]interface{}

// way to parse unknown data and find types
import (
	"encoding/json"
	"fmt"
)

func main() {
	// The JSON data we want to unmarshal.
	var rawJson map[string]interface{}

	jsonData := []byte(`{
        "name": "John Doe",
        "age": 30,
        "unknown": {
            "foo": "bar",
            "baz": 123
        }
    }`)

	err := json.Unmarshal(jsonData, &rawJson)
	if err != nil {
		panic(err)
	}

	for k, v := range rawJson {
		fmt.Printf("%v: %v, value type: %T\n", k, v, v)
	}

}

```

## parsing from web

data usually comes in as `[]bytes`

```go
func DecodeJSON() {
    jsonDataFromWeb := []byte(`
    {
      "test": 1,
      "test2": [
        1,
        2,
        3
      ]
    }
    `)
  }
```
