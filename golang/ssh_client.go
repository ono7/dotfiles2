package main

import (
    "fmt"
    "golang.org/x/crypto/ssh"
    "os"
	"time"
)

func main() {
    // Set up SSH configuration
    config := &ssh.ClientConfig{
        User: os.Getenv("ISE_SSH_USERNAME"),
        Auth: []ssh.AuthMethod{
            ssh.Password(os.Getenv("ISE_SSH_PASSWORD")),
        },
        HostKeyCallback: ssh.InsecureIgnoreHostKey(),
		Timeout: time.Duration(time.Second * 5),
    }

    // Connect to the SSH server
	client, err := ssh.Dial("tcp", os.Getenv("ISE_SSH_HOST") + ":22", config)
    if err != nil {
        panic("Failed to dial: " + err.Error())
    }
    defer client.Close()

    // Create a new SSH session
    session, err := client.NewSession()
    if err != nil {
        panic("Failed to create session: " + err.Error())
    }
    defer session.Close()

    // Run a command on the remote server
    output, err := session.Output("ls")
    if err != nil {
        panic("Failed to run command: " + err.Error())
    }

    // Print the output
    fmt.Println(string(output))
}

