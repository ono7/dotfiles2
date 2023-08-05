package main

import (
	"encoding/json"
	"fmt"
	"github.com/ono7/utils"
	"golang.org/x/crypto/ssh"
	"io"
	"os"
	"strings"
	"time"
)

// from ansible
type Provider struct {
	Provider struct {
		Username string `json:"username"`
		Password string `json:"password"`
		Host     string `json:"host"`
	} `json:"provider"`
}

// type cmdType json.RawMessage
type GenericType interface{}

// from ansible
type Cmd struct {
	Command GenericType `json:"command"`
}

// from ansible
type Prompt struct {
	Prompt GenericType `json:"prompt"`
}

type ansibleDevice struct {
	User            string
	Password        string
	Host            string
	AnsibleResponse utils.Response
	Cmd             string
}

func (i *ansibleDevice) send(rawJson []byte) (string, error) {

	if i.User == "" {
		i.AnsibleResponse.Msg = "missing provider: username"
		utils.AnsibleFail(&i.AnsibleResponse)
	} else if i.Password == "" {
		i.AnsibleResponse.Msg = "missing provider: password"
		utils.AnsibleFail(&i.AnsibleResponse)

	} else if i.Host == "" {
		i.AnsibleResponse.Msg = "missing provider: host"
		utils.AnsibleFail(&i.AnsibleResponse)
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
		utils.AnsibleFail(&i.AnsibleResponse)
	}
	defer client.Close()

	session, err := client.NewSession()
	if err != nil {
		i.AnsibleResponse.Msg = fmt.Sprintf("Session: %v", err.Error())
		utils.AnsibleFail(&i.AnsibleResponse)
	}
	defer session.Close()

	// fmt.Printf("Connected to node (%s)\n", i.Host)
	var b strings.Builder
	mW := io.MultiWriter(&b)
	session.Stdout = mW

	pipe, err := session.StdinPipe()
	if err != nil {
		i.AnsibleResponse.Msg = fmt.Sprintf("Pipe: %v", err.Error())
		utils.AnsibleFail(&i.AnsibleResponse)
	}
	defer pipe.Close()

	modes := ssh.TerminalModes{
		ssh.ECHO:  1, // Ensure echoing is enabled
		ssh.IGNCR: 0, // DONT Ignore CR on input. (needed for microtik)
	}

	if err = session.RequestPty("vty", 0, 200, modes); err != nil {
		i.AnsibleResponse.Msg = fmt.Sprintf("VTY: %v", err.Error())
		utils.AnsibleFail(&i.AnsibleResponse)
	}

	if err = session.Shell(); err != nil {
		i.AnsibleResponse.Msg = fmt.Sprintf("Shell: %v", err.Error())
		utils.AnsibleFail(&i.AnsibleResponse)
	}

	var prompt Prompt
	err = json.Unmarshal(rawJson, &prompt)
	if err != nil {
		i.AnsibleResponse.Msg = "Error unmarshaling prompt data"
		utils.AnsibleFail(&i.AnsibleResponse)
	}

	timeout := 30

	return utils.RunCmd(pipe, i.Cmd, prompt.Prompt.(string), &b, timeout)

	// var (
	//  rawErrors = []string{`syntax error \(line \d+ column \d+\)`, `bad command name \S+ \(line \d+ column \d+\)`}
	// )
}

func checkCommandErrors() {}

// Temp: "go run main.go args.json"
func main() {
	var response utils.Response

	if len(os.Args) < 2 {
		response.Msg = "No argument file provided"
		utils.AnsibleFail(&response)
	}

	argsFile := os.Args[1]

	rawJson, err := os.ReadFile(argsFile)
	if err != nil {
		response.Msg = "Could not read configuration file: " + argsFile
		fmt.Println("error reading file")
		utils.AnsibleFail(&response)
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
		utils.AnsibleFail(&response)
	}

	var command Cmd
	err = json.Unmarshal(rawJson, &command)
	if err != nil {
		response.Msg = "Error unmarshaling command data"
		utils.AnsibleFail(&response)
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
			utils.AnsibleFail(&response)
		}
		ret, err := device.send(rawJson)
		if err != nil {
			response.Msg = fmt.Sprintf("Send command error, %v, buffer: %s", err, ret)
			utils.AnsibleFail(&response)
		}
		response.Msg = "ok"
		response.Stdout = ret
		utils.AnsibleSuccess(&response)
	case []interface{}:
		response.Msg = fmt.Sprintf("command should not be a list, %v", cmd)
		utils.AnsibleFail(&response)
	}
}
