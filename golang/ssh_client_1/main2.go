package main

import (
	"flag"
	"fmt"
	"io"
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

	fmt.Printf("Attempting to connect to ise node (%s)...\n", i.ipAddr)
	session, err := client.NewSession()
	if err != nil {
		i.errMsg = err
		return false
	}
	defer session.Close()

	fmt.Printf("Connected to ise node (%s)\n", i.ipAddr)

	var b strings.Builder
	// mW := io.MultiWriter(os.Stdout, &b)
	mW := io.MultiWriter(&b)
	session.Stdout = mW

	pipe, err := session.StdinPipe()
	if err != nil {
		i.errMsg = err
		return false
	}
	defer pipe.Close()

	modes := ssh.TerminalModes{
		ssh.ECHO:  1, // Ensure echoing is enabled
		ssh.IGNCR: 1, // Ignore CR on input.
	}

	if err = session.RequestPty("vt100", 0, 200, modes); err != nil {
		i.errMsg = fmt.Errorf("request for pseudo terminal failed: %s", err)
	}

	if err = session.Shell(); err != nil {
		i.errMsg = err
		return false
	}

	i.startTime = time.Now() // Start the timer

	var (
		uPrompt = regexp.MustCompile(fmt.Sprintf(`[\s\S]*?\/%s#`, i.username)) // example: 'ise/admin#''
		sPrompt = regexp.MustCompile(`Enter session number to resume`)         // Handles if a previous ssh session found
		mPrompt = regexp.MustCompile(`--More--`)                               // Handles if session is stuck at a --More-- paginated prompt
	)

	for {
		switch {
		case sPrompt.MatchString(b.String()): // Handles if a previous ssh session was found
			const Count = 30
			fmt.Println("Found open ssh session")
			runCmd(pipe, "1")
			if mPrompt.MatchString(b.String()[len(b.String())-30:]) {
				for i := 0; i < Count; i++ {
					runCmd(pipe, "\n")
					fmt.Print(".")
					if !mPrompt.MatchString(b.String()[len(b.String())-30:]) {
						break
					}
				}
			}
			runCmd(pipe, "exit")
			if uPrompt.MatchString(b.String()[len(b.String())-10:]) {
				runCmd(pipe, "exit") // if we are still at admin#, we were in config (config)# mode, send one more exit
			}
			fmt.Println("\nSession 1 seleted, and cleared")
			return true
		case uPrompt.MatchString(b.String()): // Intial prompt after login, nothing to do here
			runCmd(pipe, "exit")
			fmt.Println("No active sessions")
			return true
		}

	}
}

func main() {
	iseNodeIP, iseNodeIPSet := os.LookupEnv("ISE_NODE_IP")
	iseUsername, iseUsernameSet := os.LookupEnv("ISE_SSH_USERNAME")
	isePassword, isePasswordSet := os.LookupEnv("ISE_SSH_PASSWORD")

	switch {
	case !iseNodeIPSet:
		fmt.Fprintln(os.Stderr, "Environment variable not set: ISE_NODE_IP")
		os.Exit(1)
	case !iseUsernameSet:
		fmt.Fprintln(os.Stderr, "Environment variable not set: ISE_SSH_USERNAME")
		os.Exit(1)
	case !isePasswordSet:
		fmt.Fprintln(os.Stderr, "Environment variable not set: ISE_SSH_PASSWORD")
		os.Exit(1)
	}

	flag.Parse()

	node := iseNode{
		ipAddr:   iseNodeIP,
		username: iseUsername,
		password: isePassword,
	}

	if success := node.process(); !success {
		fmt.Fprintf(os.Stderr, "\nssh session clear error (%s): %v\n", node.ipAddr, node.errMsg)
		os.Exit(1)
	}

	fmt.Printf("\ndone! (%s).\n", node.ipAddr)
	os.Exit(0)
}

func runCmd(w io.Writer, cmd string) {
	fmt.Fprintf(w, cmd+"\n")
	time.Sleep(1500 * time.Millisecond)
}
