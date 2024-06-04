// message queue for processing them in a serial manner with database logging
package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"sync"
	"time"

	_ "github.com/mattn/go-sqlite3"
)

// Database variables
var db *sql.DB
var stmtInsertSuccess *sql.Stmt
var stmtInsertFailure *sql.Stmt

func initDB() error {
	var err error
	db, err = sql.Open("sqlite3", "message_log.db")
	if err != nil {
		return err
	}

	_, err = db.Exec(`
		CREATE TABLE IF NOT EXISTS message_log (
			id INTEGER PRIMARY KEY AUTOINCREMENT,
			timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
			data TEXT,
			status TEXT
		)
	`)
	if err != nil {
		return err
	}

	stmtInsertSuccess, err = db.Prepare("INSERT INTO message_log (data, status) VALUES (?, 'success')")
	if err != nil {
		return err
	}

	stmtInsertFailure, err = db.Prepare("INSERT INTO message_log (data, status) VALUES (?, 'failure')")
	if err != nil {
		return err
	}

	return nil
}

// Message represents the incoming JSON data
type Message struct {
	Data string `json:"data"`
}

// queue is a simple FIFO queue to store messages
type queue struct {
	messages []*Message
	mu       sync.Mutex
}

// Push adds a message to the queue in a thread-safe manner
func (q *queue) Push(msg *Message) {
	q.mu.Lock()
	defer q.mu.Unlock()
	q.messages = append(q.messages, msg)
}

// Pop removes and returns the oldest message from the queue
func (q *queue) Pop() *Message {
	q.mu.Lock()
	defer q.mu.Unlock()
	if len(q.messages) == 0 {
		return nil
	}
	msg := q.messages[0]
	q.messages = q.messages[1:]
	return msg
}

// Create a thread-safe queue instance
var messageQueue = &queue{}

// HTTP handler function
func handler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Only POST requests allowed", http.StatusMethodNotAllowed)
		return
	}

	var msg Message
	if err := json.NewDecoder(r.Body).Decode(&msg); err != nil {
		http.Error(w, "Invalid JSON data", http.StatusBadRequest)
		log.Printf("JSON decoding error: %v\n", err) // Log the error for debugging
		return
	}

	messageQueue.Push(&msg) // Safely push to the queue
}

// Function to process messages in the queue (with panic recovery)
func processQueue() {
	defer func() {
		if r := recover(); r != nil {
			log.Printf("Recovered from panic in processQueue: %v\n", r)
		}
	}()

	for {
		msg := messageQueue.Pop()
		if msg == nil {
			time.Sleep(5 * time.Second) // Sleep if the queue is empty
			continue
		}

		log.Printf("Processing message: %s\n", msg.Data)

		_, err := stmtInsertSuccess.Exec(msg.Data)
		if err != nil {
			log.Printf("Error writing to DB: %v\n", err)
		}
	}
}

func main() {
	http.HandleFunc("/", handler)

	if err := initDB(); err != nil { // Initialize the database and check for errors
		log.Fatalf("Database initialization error: %v", err)
	}
	defer db.Close() // Close the database connection when the program ends

	// Start a goroutine to process the queue periodically (with panic recovery)
	go func() {
		defer func() {
			if r := recover(); r != nil {
				log.Printf("Recovered from panic in main goroutine: %v\n", r)
			}
		}()
		processQueue()
	}()

	fmt.Println("Service started and listening on port 8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
