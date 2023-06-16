package main

import (
	"fmt"
	"log"
	"net"
	"net/http"
	"os"
	"os/signal"
	"path"
	"strings"
	"syscall"
)

const wwwRoot = "./logs"

func main() {

	pid, err := os.Create("server.pid")
	if err != nil {
		log.Fatalf("server.pid Create: %v\n", err)
	}
	defer pid.Close()

	fmt.Fprintf(pid, "%d", os.Getpid())

	fs := http.FileServer(http.Dir(wwwRoot))
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
		// log.Printf("%s %s -> %s", r.Host, r.Method, r.URL)
		if r.Method != "GET" || len(r.Method) > 3 {
			http.Error(w, ":) We only support GET here", http.StatusNotFound)
			return
		}
		filePath := path.Base(r.URL.Path)
		log.Println(filePath)
		file, err := os.Open(filePath)
		if err != nil {
			http.Error(w, fmt.Sprintf("Failed to open file: %s", err), http.StatusInternalServerError)
			return
		}
		defer file.Close()

		// Read the contents of the file
		fileInfo, err := file.Stat()
		if err != nil {
			http.Error(w, fmt.Sprintf("Failed to get file info: %s", err), http.StatusInternalServerError)
			return
		}
		fileSize := fileInfo.Size()
		buffer := make([]byte, fileSize)
		_, err = file.Read(buffer)
		if err != nil {
			http.Error(w, fmt.Sprintf("Failed to read file: %s", err), http.StatusInternalServerError)
			return
		}

		// w.Header().Set("Content-Type", "text/plain")
		fmt.Fprintf(w, `<html>
  <head>
    <meta name="color-scheme" content="light dark">
	<meta http-equiv="refresh" content="3">
  </head>
  <body>
    <pre style="word-wrap: break-word; white-space: pre-wrap;">%s</pre>
  </body>
</html>`, buffer)

		// h.ServeHTTP(w, r)
	})
}

func handleRoot(w http.ResponseWriter, r *http.Request) {
	if r.Method != "GET" {
		http.Error(w, ":) We only support GET here", http.StatusNotFound)
		return
	}
	files, err := os.ReadDir(wwwRoot)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	fmt.Fprintf(w, `<head>
<meta http-equiv="refresh" content="3">
<h2>Automation logs</h2>
</head>`)
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
	baddies := []string{"127.0.0", ":"}
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
