package main


import (
    "fmt"


    "log"
    "strings"
    "time"


    "golang.org/x/crypto/ssh"
)


func TimeTrack(start time.Time, name string) {
    elapsed := time.Since(start)
    log.Printf("%s took %s", name, elapsed)
}


func executeCmd(hostname string, cmds []string, config *ssh.ClientConfig) string {
    modes := ssh.TerminalModes{
        ssh.ECHO:          0,     // disable echoing
        ssh.TTY_OP_ISPEED: 14400, // input speed = 14.4kbaud
        ssh.TTY_OP_OSPEED: 14400, // output speed = 14.4kbaud
    }
    conn, err := ssh.Dial("tcp", hostname+":22", config)
    if err != nil {
        log.Println(err)
    }
    session, err := conn.NewSession()
    if err != nil {
        log.Fatal(err)
    }


    // You can use session.Run() here but that only works
    // if you need a run a single command or you commands
    // are independent of each other.
    err = session.RequestPty("xterm", 80, 40, modes)
    if err != nil {
        log.Fatalf("request for pseudo terminal failed: %s", err)
    }
    stdBuf, err := session.StdoutPipe()
    if err != nil {
        log.Fatalf("request for stdout pipe failed: %s", err)
    }
    stdinBuf, err := session.StdinPipe()
    if err != nil {
        log.Fatalf("request for stdin pipe failed: %s", err)
    }
    err = session.Shell()
    if err != nil {
        log.Fatalf("failed to start shell: %s", err)
    }


    var cmd_output string


    for _, cmd := range cmds {
        stdinBuf.Write([]byte(cmd + "\n"))
        for {
            stdoutBuf := make([]byte, 1000000)
            time.Sleep(time.Millisecond * 700)
            byteCount, err := stdBuf.Read(stdoutBuf)
            if err != nil {
                log.Fatal(err)
            }
            cmd_output += string(stdoutBuf[:byteCount])
            if !(strings.Contains(string(stdoutBuf[:byteCount]), "More")) {
                break
            }
            stdinBuf.Write([]byte(" "))


        }
    }

    return cmd_output
}


func main() {

    defer TimeTrack(time.Now(), "Cisco Sandbox Device Access using GO")


    var (
        User     string = "developer"
        Password string = "C1sco12345"
        hosts           = []string{"sandbox-iosxe-latest-1.cisco.com", "sandbox-iosxe-recomm-1.cisco.com"}
        cmds            = []string{"show ip route | i 0.0.0.0/0", "show ip arp"}
    )

    
    outStrings := make(map[string]string)
    results := make(chan string, 100)


    config := &ssh.ClientConfig{
        User:            User,
        HostKeyCallback: ssh.InsecureIgnoreHostKey(),
        Auth: []ssh.AuthMethod{
            ssh.Password(Password),
        },
    }

    for _, hostname := range hosts {
        go func(hostname string) {
            results <- executeCmd(hostname, cmds, config)
        }(hostname)


    }

    for i := 0; i < len(hosts); i++ {
        res := <-results
        outStrings[hosts[i]] = res
    }


    for _, device_output := range outStrings {
        fmt.Printf("%s", device_output)
        fmt.Printf("\n================================\n\n")
    }

}
