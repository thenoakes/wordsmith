import Foundation

enum OutputType {
  case error
  case standard
}

class ConsoleIO {
    /**
        Writes a message to a given writer
        - Parameter message: text to write the given writer
        - Parameter to: the writer to write to
     */
    func write(_ message: String, to: OutputType = .standard) {
      switch to {
      case .standard:
        print("\u{001B}[;m\(message)")
      case .error:
        fputs("\u{001B}[0;31m\(message)\n", stderr)
      }
    }
    
    func printUsage() {
      let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
      write("usage:")
      write("\(executableName) -a string1 string2")
      write("or")
      write("\(executableName) -p string")
      write("or")
      write("\(executableName) -h to show usage information")
      write("Type \(executableName) without an option to enter interactive mode.")
    }
    
    func getInput() -> String {
      let keyboard = FileHandle.standardInput
      let inputData = keyboard.availableData
      let strData = String(data: inputData, encoding: String.Encoding.utf8)!
      return strData.trimmingCharacters(in: CharacterSet.newlines)
    }
}
