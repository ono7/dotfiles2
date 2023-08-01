package main

import (
	"encoding/json"
	"fmt"
	"golang.org/x/crypto/ssh"
	"io"
	"log"
	"os"
	"regexp"
	"strings"
	"time"
)

// ModuleArgs are the module inputs
type Provider struct {
	Provider struct {
		Username string `json:"username"`
		Password string `json:"password"`
		Host     string `json:"host"`
	} `json:"provider"`
}

type Cmd struct {
	Command interface{} `json:"command"`
}

// Response are the values returned from the module
type Response struct {
	Msg     string `json:"msg"`
	Stdout  string `json:"stdout"`
	Changed bool   `json:"changed"`
	Failed  bool   `json:"failed"`
}

func regexJoinSlice(s []string) string {
	return strings.Join(s, "|")
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

func (i *ansibleDevice) send() (*ansibleDevice, error) {
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

	runCmd(pipe, i.Cmd, &b)
	return i, nil

	// var (
	// 	rawErrors = []string{`syntax error \(line \d+ column \d+\)`, `bad command name \S+ \(line \d+ column \d+\)`}
	// )
}

func runCmd(w io.Writer, cmd string, b *strings.Builder) (string, error) {
	b.Reset()
	counter := 0
	_, err := fmt.Fprintf(w, cmd+"\r\n")
	if err == io.EOF {
		err = nil
	}
	if err != nil {
		log.Fatalf("runCmd -> %v\n", err)
	}
	uPrompt := regexp.MustCompile(`[>] `)
	for {
		if counter > 30 {
			// return error and string
			return b.String(), fmt.Errorf("timeout error in runCmd")
		}
		time.Sleep(300 * time.Millisecond)
		if uPrompt.MatchString(b.String()) {
			return b.String(), nil
		}
		counter++
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

	err = os.WriteFile("data.json", rawJson, 0644)
	if err != nil {
		fmt.Println("Error writing data to file:", err)
		return
	}

	var providerMy Provider
	err = json.Unmarshal(rawJson, &providerMy)
	if err != nil {
		response.Msg = "Error unmarshaling provider data"
		FailJSON(response)
	}

	// fmt.Println(providerMy)

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
		ret, err := device.send()
		if err != nil {
			response.Msg = fmt.Sprintf("Send command error, %v", err)
			FailJSON(response)
		}
		ExitJSON(ret.AnsibleResponse)
	case []interface{}:
		response.Msg = fmt.Sprintf("command should not be a list, %v", cmd)
		FailJSON(response)
	}

}
