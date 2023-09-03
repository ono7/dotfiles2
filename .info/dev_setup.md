# tools needed for developement

```sh
npm install -g live-server
npm install -g nodemon
```

`nodemon --exec go run main.go --signal SIGTERM`

when working with code that does not use main.go as entry point just adjust the
file name to be monitored

`nodemon --exec go run server.go --signal SIGTERM`
