// The main.swift file is the main entry point for a swift programme

import Foundation

// Get the number of supplied args (this includes the executable name)
let argCount = CommandLine.argc

let panagram = Panagram()

if argCount < 2 {
  panagram.interactiveMode()
} else {
  panagram.staticMode()
}

// https://www.raywenderlich.com/511-command-line-programs-on-macos-tutorial
