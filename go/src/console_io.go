package main

import (
	"bufio"
	"os"
	"path/filepath"

	"github.com/fatih/color"
)

type IO interface {
	WriteStdout(message string)
	WriteStderr(message string)
}

type ConsoleIO struct{}

func (ConsoleIO) WriteStdout(message string) {
		os.Stdout.WriteString(message + "\n")
}

func (ConsoleIO) WriteStderr(message string) {
		os.Stderr.WriteString(color.RedString(message + "\n"))
}

func (c ConsoleIO) PrintUsage() {
	executablePath, err := os.Executable()
	if err != nil {
		executablePath = "wordsmith"
	}
	executableName := filepath.Base(executablePath)
	c.WriteStdout("usage:")
	c.WriteStdout(executableName + " -a string1 string2")
	c.WriteStdout("or")
	c.WriteStdout(executableName + " -p string")
	c.WriteStdout("or")
	c.WriteStdout(executableName + " -h to show usage information")
	c.WriteStdout("Type " + executableName + " without an option to enter interactive mode.")

}

// func (ConsoleIO) GetInput() string {
// 	reader := bufio.NewReader(os.Stdin)
// 	text, _ := reader.ReadString('\n')
// 	return text
// }

func (ConsoleIO) GetInput() string {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Scan()
	return scanner.Text()
}