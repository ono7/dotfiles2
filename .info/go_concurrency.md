```go
type value struct {
  // assign the mutex to the data structure hosting the
  mu sync.Mutex
  value int
}
```
