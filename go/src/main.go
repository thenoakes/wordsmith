package main

import "os"

func main() {
	argCount := len(os.Args)

	p := Panagram{}

	if argCount < 2 {
		p.InteractiveMode()
	} else {
		p.StaticMode()
	}
}