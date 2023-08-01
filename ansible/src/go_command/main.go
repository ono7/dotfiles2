package main

import (
	"encoding/json"
	"fmt"
	"io"
	"os"
	"regexp"
	"strings"
	"time"

	"golang.org/x/crypto/ssh"
)

// from ansible
type Provider struct {
	Provider struct {
		Username string `json:"username"`
		Password string `json:"password"`
		Host     string `json:"host"`
	} `json:"provider"`
}

// from ansible
type Cmd struct {
	Command interface{} `json:"command"`
}

// send this back to ansible
type Response struct {
	Msg    string `json:"msg"`
	Stdout string `json:"stdout"`
	Failed bool   `json:"failed"`
}

func regexJoinSlice(s []string) string {
	return strings.Join(s, "|")
}

// remove first and lastline from text, usually the command prompt from the device
func stripPrompt(s string) string {
	if len(s) < 2 {
		return s
	}
	lines := strings.Split(s, "\n")
	clean := lines[1 : len(lines)-1]
	return strings.Join(clean, "\n")
}

func ExitJSON(r Response) {
	returnResponse(r)
}

func FailJSON(r Response) {
	r.Failed = true
	returnResponse(r)
}

func returnResponse(r Response) {
	var response []byte
	var err error
	response, err = json.Marshal(r)
	if err != nil {
		response, _ = json.Marshal(Response{Msg: "Invalid response object"})
	}
	fmt.Println(string(response))
	if r.Failed {
		os.Exit(1)
	} else {
		os.Exit(0)
	}
}

type ansibleDevice struct {
	User            string
	Password        string
	Host            string
	AnsibleResponse Response
	Cmd             string
}

func (i *ansibleDevice) send() (string, error) {

	if i.User == "" {
		i.AnsibleResponse.Msg = "missing provider: username"
		FailJSON(i.AnsibleResponse)
	} else if i.Password == "" {
		i.AnsibleResponse.Msg = "missing provider: password"
		FailJSON(i.AnsibleResponse)

	} else if i.Host == "" {
		i.AnsibleResponse.Msg = "missing provider: host"
		FailJSON(i.AnsibleResponse)
	}

	config := ssh.ClientConfig{
		User:            i.User,
		Auth:            []ssh.AuthMethod{ssh.Password(i.Password)},
		HostKeyCallback: ssh.InsecureIgnoreHostKey(),
		Timeout:         time.Second * 20,
	}

	client, err := ssh.Dial("tcp", i.Host+":22", &config)
	if err != nil {
		i.AnsibleResponse.Msg = fmt.Sprintf("ansibleDevice: %v", err.Error())
		FailJSON(i.AnsibleResponse)
	}
	defer client.Close()

	session, err := client.NewSession()
	if err != nil {
		i.AnsibleResponse.Msg = fmt.Sprintf("Session: %v", err.Error())
		FailJSON(i.AnsibleResponse)
	}
	defer session.Close()

	// fmt.Printf("Connected to node (%s)\n", i.Host)
	var b strings.Builder
	mW := io.MultiWriter(&b)
	session.Stdout = mW

	pipe, err := session.StdinPipe()
	if err != nil {
		i.AnsibleResponse.Msg = fmt.Sprintf("Pipe: %v", err.Error())
		FailJSON(i.AnsibleResponse)
	}
	defer pipe.Close()

	modes := ssh.TerminalModes{
		ssh.ECHO:  1, // Ensure echoing is enabled
		ssh.IGNCR: 0, // DONT Ignore CR on input. (needed for microtik)
	}

	if err = session.RequestPty("vty", 0, 200, modes); err != nil {
		i.AnsibleResponse.Msg = fmt.Sprintf("VTY: %v", err.Error())
		FailJSON(i.AnsibleResponse)
	}

	if err = session.Shell(); err != nil {
		i.AnsibleResponse.Msg = fmt.Sprintf("Shell: %v", err.Error())
		FailJSON(i.AnsibleResponse)
	}

	return runCmd(pipe, i.Cmd, &b)

	// var (
	//  rawErrors = []string{`syntax error \(line \d+ column \d+\)`, `bad command name \S+ \(line \d+ column \d+\)`}
	// )
}

func checkCommandErrors() {}

func runCmd(w io.Writer, cmd string, b *strings.Builder) (string, error) {
	b.Reset()
	counter := 0
	uPrompt := regexp.MustCompile(`[>] `)
	// TODO: jlima ~ take in prompt regex through ModuleArgs
	// TODO: jlima ~ check for errors using rawErrors
	for {
		time.Sleep(50 * time.Millisecond)
		if uPrompt.MatchString(b.String()) {
			if counter >= 120 {
				return stripPrompt(b.String()), fmt.Errorf("timeout error in runCmd")
			}
			if counter == 0 {
				b.Reset()
				_, err := fmt.Fprintf(w, cmd+"\r\n")
				if err == io.EOF {
					err = nil
				}
				if err != nil {
					return stripPrompt(b.String()), fmt.Errorf("error in runCmd after sending command: %v", err)
				}
				for {
					// wait for response
					if uPrompt.MatchString(b.String()) {
						return stripPrompt(b.String()), nil
					}
					counter++
					time.Sleep(300 * time.Millisecond)
				}
			}
		}
	}
}

// Temp: "go run main.go args.json"
func main() {
	var response Response

	if len(os.Args) < 2 {
		response.Msg = "No argument file provided"
		FailJSON(response)
	}

	argsFile := os.Args[1]

	rawJson, err := os.ReadFile(argsFile)
	if err != nil {
		response.Msg = "Could not read configuration file: " + argsFile
		fmt.Println("error reading file")
		FailJSON(response)
	}

	// err = os.WriteFile("data.json", rawJson, 0644)
	// if err != nil {
	// 	fmt.Println("Error writing data to file:", err)
	// 	return
	// }

	var providerMy Provider
	err = json.Unmarshal(rawJson, &providerMy)
	if err != nil {
		response.Msg = "Error unmarshaling provider data"
		FailJSON(response)
	}

	var command Cmd
	err = json.Unmarshal(rawJson, &command)
	if err != nil {
		response.Msg = "Error unmarshaling command data"
		FailJSON(response)
	}
	var device ansibleDevice
	device.Host = providerMy.Provider.Host
	device.Password = providerMy.Provider.Password
	device.User = providerMy.Provider.Username
	device.AnsibleResponse = response
	switch cmd := command.Command.(type) {
	case string:
		device.Cmd = cmd
		if cmd == "" {
			response.Msg = "module argument: command, is empty"
			FailJSON(response)
		}
		ret, err := device.send()
		if err != nil {
			response.Msg = fmt.Sprintf("Send command error, %v", err)
			FailJSON(response)
		}
		response.Msg = "ok"
		response.Stdout = ret
		ExitJSON(response)
	case []interface{}:
		response.Msg = fmt.Sprintf("command should not be a list, %v", cmd)
		FailJSON(response)
	}

}
