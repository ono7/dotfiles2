package main

import (
    "bufio"
    "fmt"
    "golang.org/x/crypto/ssh"
    "log"
    "os"
)

func main() {
    config := &ssh.ClientConfig{
        User: "username",
        Auth: []ssh.AuthMethod{
            ssh.Password("password"),
        },
        HostKeyCallback: ssh.InsecureIgnoreHostKey(),
    }

    client, err := ssh.Dial("tcp", "remote.host:22", config)
    if err != nil {
        log.Fatal("Failed to dial: ", err)
    }
    defer client.Close()

    session, err := client.NewSession()
    if err != nil {
        log.Fatal("Failed to create session: ", err)
    }
    defer session.Close()

    session.Stdin = os.Stdin
    session.Stdout = os.Stdout
    session.Stderr = os.Stderr

    err = session.Shell()
    if err != nil {
        log.Fatal("Failed to start shell: ", err)
    }

    scanner := bufio.NewScanner(os.Stdin)
    for scanner.Scan() {
        _, err = session.Write([]byte(scanner.Text() + "\n"))
        if err != nil {
            log.Fatal("Failed to write to session: ", err)
        }
    }
}

