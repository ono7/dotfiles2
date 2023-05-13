package main

import (
	"fmt"
	"io"
	"log"
	"os"
	"regexp"
	"strings"
	"time"
	"unicode"

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

// returns string literals for regex consumption
func regexEscapeSlice(s []string) []string {
	var n []string

	for _, v := range s {
		n = append(n, regexp.QuoteMeta(v))
	}
	return n
}

// returns regex OR operator string
func regexJoinSlice(s []string) string {
	return strings.Join(s, "|")
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
	filteredWriter := NewFilteredWriter(mW, func(r rune) bool {
		return r != '\t' || r != '\n' || r != '\r' || !unicode.IsPrint(r)
	})
	// session.Stdout = mW
	session.Stdout = filteredWriter

	pipe, err := session.StdinPipe()
	if err != nil {
		i.errMsg = err
		fmt.Printf("session.StdinPipe -> %v", err)
		return false
	}
	defer pipe.Close()

	modes := ssh.TerminalModes{
		ssh.ECHO:    1, // Ensure echoing is enabled
		ssh.IGNCR:   0, // DONT Ignore CR on input. (needed for microtik)
		ssh.ECHOCTL: 0,
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
		// bad command name rstaote (line 1 column 1)
		// syntax error (line 1 column 7)
		rawErrors = []string{`syntax error \(line \d+ column \d+\)`, `bad command name \S+ \(line \d+ column \d+\)`}
		uPrompt   = regexp.MustCompile(`[>] `) // example: 'ise/admin#''
		errPrompt = regexp.MustCompile(regexJoinSlice(rawErrors))
	)

	var deployed bool

	for {
		time.Sleep(1 * time.Second)
		switch {
		case errPrompt.MatchString(b.String()): // check for errors first
			i.errMsg = fmt.Errorf("in errPrompt: %v", errPrompt.FindString(b.String()))
			runCmd(pipe, "quit", &b)
			return false
		case deployed:
			return true
		case uPrompt.MatchString(b.String()):
			if !deployed {
				runCmd(pipe, "/ip/address/print", &b)
			}
			deployed = true // mark and run once more to check for errors
		}
	}
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

type FilteredWriter struct {
	writer io.Writer
	filter func(r rune) bool
}

func NewFilteredWriter(writer io.Writer, filter func(r rune) bool) *FilteredWriter {
	return &FilteredWriter{
		writer: writer,
		filter: filter,
	}
}

// Write filters out non-printable characters
func (fw *FilteredWriter) Write(p []byte) (n int, err error) {
	var filteredRunes []rune
	for _, b := range p {
		if fw.filter(rune(b)) {
			filteredRunes = append(filteredRunes, rune(b))
		}
	}
	filteredBytes := []byte(string(filteredRunes))

	return fw.writer.Write(filteredBytes)
}

func runCmd(w io.Writer, cmd string, b *strings.Builder) {
	b.Reset() // clear stdout before each command
	_, err := fmt.Fprintf(w, cmd+"\r\n")
	if err == io.EOF {
		err = nil
	}
	if err != nil {
		log.Fatalf("runCmd -> %v\n", err)
	}
	time.Sleep(300 * time.Millisecond)
}
