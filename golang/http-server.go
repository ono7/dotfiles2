package main

import (
	"flag"
	"fmt"
	"log"
	"net"
	"net/http"
	"path/filepath"
	"strings"
	"syscall"
	"time"

	"golang.org/x/sys/unix"
)

const (
	DIRECTORY = "images/"
)

func main() {
	port := flag.String("port", "8000", "set tcp listening port for this service")
	flag.Parse()

	fs := http.FileServer(http.Dir(DIRECTORY))
	http.Handle("/", logTransferTime(restrictDirectory(fs, DIRECTORY)))

	listener, err := net.Listen("tcp", fmt.Sprintf(":%s", *port)) // Create listener directly
	if err != nil {
		log.Fatalf("Failed to listen: %v", err)
	}

	// Apply TCP options on the listener
	applyTCPSettings(listener)

	log.Printf("Starting server on port %s...\n", *port)
	if err := http.Serve(listener, nil); err != nil {
		log.Fatalf("Failed to start server: %s", err)
	}
}

// logTransferTime logs the time taken to transfer the file
func logTransferTime(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		start := time.Now()
		next.ServeHTTP(w, r)
		duration := time.Since(start)
		log.Printf("Transferred %s in %v\n", r.URL.Path, duration)
	})
}

// restrictDirectory ensures the path is within the DIRECTORY
func restrictDirectory(next http.Handler, dir string) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		path := r.URL.Path
		cleanPath := filepath.Clean(path)
		if !strings.HasPrefix(cleanPath, "/") {
			cleanPath = "/" + cleanPath
		}
		fullPath := filepath.Join(dir, cleanPath)
		if !strings.HasPrefix(fullPath, dir) {
			http.Error(w, "Forbidden", http.StatusForbidden)
			return
		}
		next.ServeHTTP(w, r)
	})
}

func applyTCPSettings(listener net.Listener) {
	tcpClampSize := 65535
	file, err := listener.(*net.TCPListener).File()
	if err != nil {
		log.Fatalf("Failed to get listener file: %v", err)
	}
	defer file.Close()

	// Enable SACK (Selective Acknowledgments), this is linux specific
	if err := syscall.SetsockoptInt(int(file.Fd()), syscall.IPPROTO_TCP, unix.TCPOPT_SACK, 1); err != nil {
		log.Fatalf("Failed to enable SACK: %v", err)
	}
	log.Println("TCP SACK enabled")

	// Set and clamp the receive buffer size (indirectly controls window size)
	if err := syscall.SetsockoptInt(int(file.Fd()), syscall.SOL_SOCKET, syscall.SO_RCVBUF, tcpClampSize); err != nil {
		log.Fatalf("Failed to set SO_RCVBUF: %v", err)
	}

	if err := syscall.SetsockoptInt(int(file.Fd()), syscall.IPPROTO_TCP, syscall.TCP_WINDOW_CLAMP, tcpClampSize); err != nil {
		log.Fatalf("Failed to set TCP_WINDOW_CLAMP: %v", err)
	}
	log.Println("TCP Window Clamp set to 65535")
}
