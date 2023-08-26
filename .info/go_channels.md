# channels

```go
msgCh := make(chan string, 10)
msgCh <- "a"
msgCh <- "b"
msgCh <- "c"
msgCh <- "d"
close(msgCh) // close channel to let sinks know we are done
```

- channels return bool when they are ok

```go
for {
    msg, ok := <- msgCh
    if !ok {
        break
      }
    fmt.Println("getting data ->", msg)
  }
```
