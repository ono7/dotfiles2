# working with json data

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
