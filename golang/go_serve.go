package main

import (
	"flag"
	"fmt"
	"log"
	"net"
	"net/http"
	"os"
	"os/signal"
	"path"
	"path/filepath"
	"regexp"
	"strings"
	"syscall"
)

const wwwRoot = "./logs"

var port string

func init() {
	flag.StringVar(&port, "p", "9191", "-p <port_number>")
	flag.Parse()
}

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
	displayServerAddress(port)

	addr := fmt.Sprintf(":%s", port)
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
		// log.Println(filePath)
		file, err := os.Open(filepath.Join(wwwRoot, filePath))
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
		p := regexp.MustCompile(`\x1B(?:[@-Z\\-_=(>][B]?|\[[0-?rm7]*[ -/]*[@-~])|[\x08]`)
		filtered := p.ReplaceAllString(string(buffer), "")

		// w.Header().Set("Content-Type", "text/plain")
		fmt.Fprintf(w, `
<!DOCTYPE html>
<html>
<head>
  <style>
    body {
      background-color: rgb(45, 58, 69);
      color: rgb(199, 207, 247);
    }
	a:link,
    a:visited {
      color: rgb(199, 207, 247);
	  text-decoration: none !important;
    }
  </style>
  <script>
    var refreshEnabled = true;

    function toggleRefresh() {
      refreshEnabled = !refreshEnabled;
      var btn = document.getElementById("toggleBtn");
      if (refreshEnabled) {
        btn.innerText = "Pause log";
        refreshPage();
      } else {
        btn.innerText = "Continue";
      }
    }

    function refreshPage() {
      if (refreshEnabled) {
        location.reload();
      }
    }

    document.addEventListener('DOMContentLoaded', function() {
      setTimeout(function() {
        var element = document.getElementById('logs');

        if (element) {
          element.scrollIntoView();
        }
      }, 1000); // Increased the timeout to 1000ms for better visibility in case of long log files
    });
  </script>
</head>
<body>
  <pre style="word-wrap: break-word; white-space: pre-wrap;">%s</pre>
  <button id="toggleBtn" onclick="toggleRefresh()">Pause log</button>
  <p id="logs"></p>
  <script>
    setInterval(refreshPage, 3000); // Refresh the page every 3 seconds (adjust as needed)
  </script>
</body>
</html>
`, filtered)

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
		http.Error(w, "Waiting for logs...", http.StatusInternalServerError)
		return
	}

	fmt.Fprintf(w, `<html><head>
	<style>
		body {
			color: rgb(199, 207, 247);
			background-color: rgb(45, 58, 69);
		}
		a:link,
		a:visited {
			color: rgb(199, 207, 247);
			text-decoration: none !important;
		}
	</style>
	<meta http-equiv="refresh" content="3">
</head>`)
	fmt.Fprintf(w, `<body>
	<h2>Automation logs</h2>
	`)
	fmt.Fprint(w, "<ul>")
	for _, file := range files {
		fileName := file.Name()
		filePath := filepath.Join(wwwRoot, fileName)
		fileInfo, err := os.Stat(filePath)
		if err != nil {
			fmt.Fprintf(w, "<li>%s</li>", fileName)
			continue
		}
		lastModified := fileInfo.ModTime().Format("2006-01-02 15:04:05")
		fmt.Fprintf(w, "<li><a href=\"/files/%s\"> %s - %s</a></li>", fileName, lastModified, fileName)
	}
	fmt.Fprint(w, "</ul>")
	fmt.Fprintf(w, `</body>`)
	fmt.Fprintf(w, `</head></html>`)
}

func waitForTerm() {
	stop := make(chan os.Signal, 1)
	signal.Notify(stop, os.Interrupt, syscall.SIGTERM)
	<-stop
	log.Println("Term signal recieved, shutting down server....")
	err := os.Remove("server.pid")
	if err != nil {
		log.Println("failed to remove server.pid")
	}
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
	// logFile, err := os.Create("server.info")
	// if err != nil {
	// 	log.Fatalf("server.info Create: %v\n", err)
	// }
	// defer logFile.Close()

	for _, addr := range addrs {
		if testIp(addr.String()) {
			ip := strings.Split(addr.String(), "/")[0]
			log.Printf("http://%s:%s", ip, p)
			// fmt.Fprintf(logFile, "http://%s:%s\n", ip, p)
		}
	}

}
