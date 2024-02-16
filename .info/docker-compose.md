# 


```Dockerfile
version: '3'

services:
  jenkins:
    image: go
    ports:
      - "8080:8080"
    volumes:
      # mount local PWD to /go/src
      - .:/go/src
```
