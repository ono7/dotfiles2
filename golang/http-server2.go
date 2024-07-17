package main

import (
	"flag"
	"fmt"
	"io"
	"log"
	"net"
	"net/http"
	"os"
	"path/filepath"
	"strings"
	"syscall"
	"time"

	"golang.org/x/sys/unix"
)

// files should be placed in this directory to be served
const (
	DIRECTORY    = "images/"
	LOG_INTERVAL = 10 // Log progress every 10%
)

func main() {
	logFile, err := os.OpenFile("server.log", os.O_RDWR|os.O_CREATE|os.O_APPEND, 0644)
	if err != nil {
		log.Fatalf("Error opening log file: %v", err)
	}
	defer logFile.Close()

	mw := io.MultiWriter(os.Stdout, logFile) // Write to both stdout and the file
	log.SetOutput(mw)

	port := flag.String("port", "8000", "Set TCP port to listen on")
	flag.Parse()

	fs := http.FileServer(http.Dir(DIRECTORY))
	http.Handle("/", imageTransfer(handleRequests(fs, DIRECTORY)))

	listener, err := net.Listen("tcp", fmt.Sprintf(":%s", *port))
	if err != nil {
		log.Fatalf("Failed to listen: %v", err)
	}

	// Apply TCP connection parameters before starting the server
	applyTCPSettings(listener)

	log.Printf("Starting server on port %s...\n", *port)
	if err := http.Serve(listener, nil); err != nil {
		log.Fatalf("Failed to start server: %s", err)
	}
}

// progressWriter is a custom writer that tracks the number of bytes written
type progressWriter struct {
	http.ResponseWriter
	total        int64
	written      int64
	nextLogPoint int64
	clientIP     string
}

func (pw *progressWriter) Write(p []byte) (int, error) {
	n, err := pw.ResponseWriter.Write(p)
	pw.written += int64(n)
	pw.reportProgress()
	return n, err
}

func (pw *progressWriter) reportProgress() {
	if pw.total > 0 {
		progress := float64(pw.written) / float64(pw.total) * 100
		if pw.written >= pw.nextLogPoint {
			log.Printf("%s Progress: %.2f%% (%d/%d bytes)\n", pw.clientIP, progress, pw.written, pw.total)
			pw.nextLogPoint += int64(pw.total * LOG_INTERVAL / 100)
		}
	} else {
		log.Printf("Written %d bytes (total size unknown) from %s\n", pw.written, pw.clientIP)
	}
}

// imageTransfer serves files and logs transfer times and progress
func imageTransfer(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		start := time.Now()
		fileInfo, err := os.Stat(filepath.Join(DIRECTORY, r.URL.Path))
		var total int64
		if err == nil {
			total = fileInfo.Size()
		}

		pw := &progressWriter{
			ResponseWriter: w,
			total:          total,
			nextLogPoint:   int64(total * LOG_INTERVAL / 100),
			clientIP:       r.RemoteAddr,
		}
		next.ServeHTTP(pw, r)
		duration := time.Since(start)
		log.Printf("%s %s %s in %v\n", r.RemoteAddr, r.Method, r.URL.Path, duration)
	})
}

// handleRequests ensures the path is confined to the DIRECTORY constant
func handleRequests(next http.Handler, dir string) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if r.Method != "GET" {
			http.Error(w, "Method Not Allowed", http.StatusMethodNotAllowed)
			return
		}
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

// Optimize for slow WAN links with high latency, settings/syscalls are OS-specific and
// *** THIS IS SPECIFIC TO THE OS API/SYSCALLS - Linux, MacOS, and Windows ***
func applyTCPSettings(listener net.Listener) {
	border := strings.Repeat("*", 40)
	log.Println(border)
	defer log.Println(border)
	tcpClampSize := 65535
	file, err := listener.(*net.TCPListener).File()
	if err != nil {
		log.Fatalf("Failed to get listener file: %v", err)
	}
	defer file.Close()

	// Enable SaCK (Selective Acknowledgments)
	if err := syscall.SetsockoptInt(int(file.Fd()), syscall.IPPROTO_TCP, unix.TCPOPT_SACK, 1); err != nil {
		log.Fatalf("Failed to enable SaCK: %v", err)
	}
	log.Println("TCP SaCK enabled")

	// Set and clamp the receive buffer size (indirectly controls window size)
	if err := syscall.SetsockoptInt(int(file.Fd()), syscall.SOL_SOCKET, syscall.SO_RCVBUF, tcpClampSize); err != nil {
		log.Fatalf("Failed to set SO_RCVBUF: %v", err)
	}

	// Negotiate better clamp size for high latency links
	if err := syscall.SetsockoptInt(int(file.Fd()), syscall.IPPROTO_TCP, syscall.TCP_WINDOW_CLAMP, tcpClampSize); err != nil {
		log.Fatalf("Failed to set TCP_WINDOW_CLAMP: %v", err)
	}
	log.Println("TCP Window Clamp set to", tcpClampSize)
}
