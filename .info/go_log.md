# logger facilities

create custom handlers for golang

```go
l := log.New(os.Stdout, "product-api: ", log.LstdFlags)
```

```log
Listening on http://localhost:9090
product-api: 2024/05/19 11:10:01 Hello world!!!
product-api: 2024/05/19 11:10:01
product-api: 2024/05/19 11:10:01 Hello world!!!
product-api: 2024/05/19 11:10:01
```
