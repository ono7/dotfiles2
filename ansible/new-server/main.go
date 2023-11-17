package main

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
)

func main() {
	side := "a"
	dir := filepath.Join(os.TempDir(), "go", side)
	fmt.Println(dir)
	cmd := exec.Command("env", "| grep", "test")
	cmd.Env = []string{"test=yay"}
	cmd.Stdout = os.Stdout
	if err := cmd.Run(); err != nil {
		panic(err)
	}
}
