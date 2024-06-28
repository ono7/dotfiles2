package main

import (
	"flag"
	"fmt"
	"log"
	"net"
	"net/http"
	"os"
	"os/exec"
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
	err := checkSslCert("server.key")
	if err != nil {
		log.Fatal(err)
	}
	port := flag.String("port", "8000", "set tcp listening port for this service")
	flag.Parse()

	fs := http.FileServer(http.Dir(DIRECTORY))
	http.Handle("/", imageTransfer(restrictDirectory(fs, DIRECTORY)))

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

// NOTE(jlima773):
// checks for certificate and ssl certificate key to use for tls, if it does not exists, it
// attemps to create a pair using openssl. you can always ship the cert and key
// with this package to avoid issues, openssl must be installed on the server
// hosting this service for this bootstrap process to work...
func checkSslCert(f string) error {
	_, err := os.Open(f)
	if err != nil {
		if strings.Contains(err.Error(), "no such file or directory") {
			genkey := exec.Command("openssl", "genpkey", "-algorithm", "RSA", "-out", "server.key")
			if err := genkey.Run(); err != nil {
				return fmt.Errorf("error generating key: %w", err)
			}
			log.Println("ssk key generated")

			createCert := exec.Command("openssl", "req", "-new", "-x509", "-key", "server.key", "-out", "server.crt", "-days", "5000", "-subj", "/C=US/ST=TX/L=Northlake/O=marriott.com/OU=NetworkDevOps/CN=localhost")
			if err := createCert.Run(); err != nil {
				return fmt.Errorf("error generating cert: %w", err)
			}
			log.Println("ssl cert created")
			return nil // No error after generating the certificate
		}

		return fmt.Errorf("opening file %s: %w", f, err) // Wrap the error
	}

	return nil // No errors
}

// imageTransfer logs the time taken to transfer the file
func imageTransfer(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		start := time.Now()
		next.ServeHTTP(w, r)
		duration := time.Since(start)
		log.Printf("%s Transferred %s in %v\n", r.RemoteAddr, r.URL.Path, duration)
	})
}

// restrictDirectory ensures the path is within the DIRECTORY
func restrictDirectory(next http.Handler, dir string) http.Handler {
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
