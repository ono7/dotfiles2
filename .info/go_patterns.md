```go
// open file
	file, err := os.Open("all-virtual-server.json")
	if err != nil {
		panic(err)
	}
	defer file.Close()
```
