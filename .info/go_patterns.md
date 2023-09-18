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
