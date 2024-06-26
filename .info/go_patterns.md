# go os signal kill (graceful shutdown)

```go
var wg sync.WaitGroup

	// Channel to catch OS signals
	sigChan := make(chan os.Signal, 1)
	signal.Notify(sigChan, syscall.SIGINT, syscall.SIGTERM)

	go func() {
		for {
			conn, err := listener.Accept()
			if err != nil {
				log.Printf("failed to accept incoming connection: %s", err)
				return
			}

			wg.Add(1)
			go handleConnection(conn, config, &wg)
		}
	}()

	// Wait for termination signal
	<-sigChan
	log.Println("Shutting down server...")
	listener.Close()

	wg.Wait()
	log.Println("Server gracefully stopped")
```

```go
// open file
	file, err := os.Open("all-virtual-server.json")
	if err != nil {
		panic(err)
	}
	defer file.Close()
```

```go
// go routine basic pattern

package main

import (
	"fmt"
	"sync"
	"time"
)

func main() {
	start := time.Now()
	userName := fetchuser()

	respch := make(chan any, 2)

	wg := &sync.WaitGroup{}

	wg.Add(2) // how many should we wait for
	go fetchUserLikes(userName, respch, wg)
	go fetchUserMatch(userName, respch, wg)
	wg.Wait() // block until 2 wg's are Done()
	close(respch) // close channel after done

	for resp := range respch {
		fmt.Println("resp from cha: ", resp)
	}

	fmt.Println("exec time: ", time.Since(start))

}

func fetchuser() string {
	time.Sleep(time.Millisecond * 100)
	return "Bob"
}
func fetchUserLikes(userName string, respch chan any, wg *sync.WaitGroup) {
	time.Sleep(time.Millisecond * 150)
	respch <- 11 // add data to channel
	wg.Done() // close WaitGroup to notify wg that we are done
}

func fetchUserMatch(userName string, respch chan any, wg *sync.WaitGroup) {
	time.Sleep(time.Millisecond * 100)
	respch <- "Anna"
	wg.Done()
}
```

```go
// count matching elements in a slice
package main

import (
    "fmt"
    "strings"
)

func count[T any](slice []T, f func(T) bool) int {
    count := 0
    for _, s := range slice {
        if f(s) {
            count++
        }
    }
    return count
}

func main() {
    s := []string{"ab", "ac", "de", "at", "gfb", "fr"}
    fmt.Println(
        count(
            s,
            func(x string) bool {
                return strings.Contains(x, "a")
            }),
    )

    s2 := []int{1, 2, 3, 4, 5, 6}
    fmt.Println(
        count(
            s2,
            func(x int) bool {
                return x%3 == 0
            }),
    )
}
```
