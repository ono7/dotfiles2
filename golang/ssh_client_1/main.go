package main

import (
	"flag"
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

	fmt.Printf("Attempting to connect to ise node (%s)...\n", i.ipAddr)
	session, err := client.NewSession()
	if err != nil {
		i.errMsg = err
		return false
	}
	defer session.Close()

	fmt.Printf("Connected to ise node (%s)\n", i.ipAddr)

	var b strings.Builder
	session.Stdout = &b

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

	if err = session.RequestPty("vt100", 80, 40, modes); err != nil {
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
	)

	for {
		switch {
		case sPrompt.MatchString(b.String()):
			runCmd(pipe, "/ip/address/print")
			return true
		case uPrompt.MatchString(b.String()):
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
	n, err := fmt.Fprintf(w, cmd+"\n")
	if err != nil {
		log.Fatal(err)
	}
	if n <= 1 {
		fmt.Printf("Something wrong with this commnand?\nBytes Written: %v\nCommand: %v", n, cmd)
	}
	time.Sleep(300 * time.Millisecond)
}
