package main

import (
        "fmt"
        "syscall"
        // "io"
        "log"
        "net"
        "net/http"
        "os"
        "os/signal"

        // "path/filepath"
        "strings"
)

func main() {

        pid, err := os.Create("server.pid")
        if err != nil {
                log.Fatalf("server.pid Create: %v\n", err)
        }
        defer pid.Close()

        fmt.Fprintf(pid, "%d", os.Getpid())
        fs := http.FileServer(http.Dir("./logs"))
        http.Handle("/files/", handleReq(http.StripPrefix("/files", fs)))
        http.HandleFunc("/", handleRoot)

        // TODO: jlima ~ maket his server port dynamic
        displayServerAddress("8080")

        addr := ":8080"
        log.Printf("Starting server on port %s\n", addr)
        go func() {
                log.Fatal(http.ListenAndServe(addr, nil))
        }()
        log.Println("Server started...")
        waitForTerm()
}

func handleReq(h http.Handler) http.Handler {
        return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
                log.Printf("%s %s -> %s", r.Host, r.Method, r.URL)
                if r.Method != "GET" || len(r.Method) > 3 {
                        http.Error(w, ":) We only support GET here", http.StatusNotFound)
                        return
                }
                h.ServeHTTP(w, r)
        })
}

func handleRoot(w http.ResponseWriter, r *http.Request) {
        if r.Method != "GET" {
                http.Error(w, ":) We only support GET here", http.StatusNotFound)
                return
        }
        files, err := os.ReadDir("./logs")
        if err != nil {
                http.Error(w, err.Error(), http.StatusInternalServerError)
                return
        }

        fmt.Fprint(w, "<h1>")
        fmt.Fprint(w, "<head>Automation log files :)</head>")
        fmt.Fprint(w, "</h1>")
        fmt.Fprint(w, "<ul>")
        for _, file := range files {
                fmt.Fprintf(w, "<li><a href=\"/files/%s\">%s</a></li>", file.Name(), file.Name())
        }
        fmt.Fprint(w, "</ul>")
}

func waitForTerm() {
        stop := make(chan os.Signal, 1)
        signal.Notify(stop, os.Interrupt, syscall.SIGTERM)
        <-stop
        log.Println("Term signal recieved, shutting down server....")
}

func testIp(s string) bool {
        baddies := []string{"127.0.0", "::"}
        for _, x := range baddies {
                if strings.Contains(s, x) {
                        return false
                }
        }
        return true
}

func displayServerAddress(p string) {
        addrs, err := net.InterfaceAddrs()
        if err != nil {
                log.Println("Error retrieving network interface addresses:", err)
                return
        }
        logFile, err := os.Create("server.info")
        if err != nil {
                log.Fatalf("server.info Create: %v\n", err)
        }
        defer logFile.Close()

        for _, addr := range addrs {
                if testIp(addr.String()) {
                        ip := strings.Split(addr.String(), "/")[0]
                        log.Printf("http://%s:%s", ip, p)
                        fmt.Fprintf(logFile, "http://%s:%s\n", ip, p)
                }
        }

}

