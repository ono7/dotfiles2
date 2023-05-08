package main

import (
	"fmt"
	"io"
	"log"
	"os"
	"regexp"
	"strings"
	"time"

	"golang.org/x/crypto/ssh"
)

type iseNode struct {
	ipAddr      string
	username    string
	password    string
	startTime   time.Time
	endTime     time.Time
	elapsedTime time.Duration
	errMsg      error
}

func (i *iseNode) process() bool {
	config := ssh.ClientConfig{
		User:            i.username,
		Auth:            []ssh.AuthMethod{ssh.Password(i.password)},
		HostKeyCallback: ssh.InsecureIgnoreHostKey(),
		Timeout:         time.Second * 20,
	}

	client, err := ssh.Dial("tcp", i.ipAddr+":22", &config)
	if err != nil {
		i.errMsg = err
		return false
	}
	defer client.Close()

	fmt.Printf("Attempting to connect to node (%s)...\n", i.ipAddr)
	session, err := client.NewSession()
	if err != nil {
		i.errMsg = err
		return false
	}
	defer session.Close()

	fmt.Printf("Connected to node (%s)\n", i.ipAddr)

	var b strings.Builder
	mW := io.MultiWriter(os.Stdout, &b)
	// mW := io.MultiWriter(&b)
	session.Stdout = mW

	pipe, err := session.StdinPipe()
	if err != nil {
		i.errMsg = err
		fmt.Printf("session.StdinPipe -> %v", err)
		return false
	}
	defer pipe.Close()

	modes := ssh.TerminalModes{
		ssh.ECHO:  1, // Ensure echoing is enabled
		ssh.IGNCR: 0, // Ignore CR on input.
	}

	if err = session.RequestPty("vty", 0, 200, modes); err != nil {
		i.errMsg = fmt.Errorf("request for pseudo terminal failed: %s", err)
	}
	fmt.Println("PTY acquired...")

	if err = session.Shell(); err != nil {
		i.errMsg = err
		return false
	}
	fmt.Println("shell acquaired...")

	i.startTime = time.Now() // Start the timer

	var (
		uPrompt = regexp.MustCompile(`[>] `) // example: 'ise/admin#''
		// mPrompt = regexp.MustCompile(`--More--`)                               // Handles if session is stuck at a --More-- paginated prompt
	)
	for {
		time.Sleep(1 * time.Second)
		if uPrompt.MatchString(b.String()) {
			runCmd(pipe, "/ip/address/print\r\n")
			if uPrompt.MatchString(b.String()[b.Len()-10:]) {
				fmt.Println("Exit point")
				break
			}
		}
	}

	return true
}

func main() {

	node := iseNode{
		ipAddr:   "",
		username: "",
		password: "",
	}

	if success := node.process(); !success {
		fmt.Fprintf(os.Stderr, "\nssh session clear error (%s): %v\n", node.ipAddr, node.errMsg)
		os.Exit(1)
	}

	fmt.Printf("\ndone! (%s).\n", node.ipAddr)
	os.Exit(0)
}

func runCmd(w io.Writer, cmd string) {
	_, err := fmt.Fprintf(w, cmd+"\r\n")
	if err != nil {
		log.Fatalf("runCmd -> %v\n", err)
	}
	time.Sleep(300 * time.Millisecond)
}
