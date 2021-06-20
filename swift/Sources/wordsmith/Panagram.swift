import Foundation

enum OptionType: String {
  case palindrome = "p"
  case anagram = "a"
  case help = "h"
  case unknown
  case quit = "q"

  init(value: String) {
    switch value {
    case "a": self = .anagram
    case "p": self = .palindrome
    case "h": self = .help
    case "q": self = .quit
    default: self = .unknown
    }
  }
}

class Panagram {

    let consoleIO = ConsoleIO()

    /**
    Prints a message informing a user of the wrong number of arguments
     - Parameter discrimnator: If true, indicates too many arguments instead of too few
     - Parameter option:The provided option
     */
    func badArgs(_ tooMany: Bool, option: String) {
        consoleIO.write(
            "Too \(tooMany ? "many" : "few") arguments for option \(option)",
            to: .error)
        consoleIO.printUsage()
    }
    
    func badMode(_ mode: String) {
        consoleIO.write("Unknown option \(mode)", to: .error)
    }
    
    func isOrNot(_ ifTrue: Bool) -> String {
        return "is\(ifTrue ? "" : " not")"
    }
    
    func staticMode() {
        let argCount = CommandLine.argc
        
        // The first argument will be the mode (prefixed with a dash character)
        let modeArg = CommandLine.arguments[1]
        
        // Slice first character
        let mode = String(modeArg[modeArg.index(modeArg.startIndex, offsetBy: 1)...])
        
        let (option, value) = getOption(mode)
        
        switch option {
        case .anagram:
            if argCount != 4 {
                badArgs(argCount > 4, option: option.rawValue)
            } else {
                let arg1 = CommandLine.arguments[2]
                let arg2 = CommandLine.arguments[3]
                consoleIO.write("\(arg2) \(isOrNot(arg1.isAnagramOf(arg2))) an anagram of \(arg1)")
            }
            
        case .palindrome:
            if argCount != 3 {
                badArgs(argCount > 3, option: option.rawValue)
            } else {
                let arg = CommandLine.arguments[2]
                consoleIO.write("\(arg) \(isOrNot(arg.isPalindrome())) a palindrome")
            }
            
        case .help:
            consoleIO.printUsage()
            
        case .unknown, .quit:
            badMode(value)
            consoleIO.printUsage()
        }
    }
    
    func interactiveMode() {
      consoleIO.write("Welcome to Panagram. This program checks if an input string is an anagram or palindrome.")

      var shouldQuit = false
      while !shouldQuit {
        consoleIO.write("Type 'a' to check for anagrams or 'p' for palindromes type 'q' to quit.")
        let (option, value) = getOption(consoleIO.getInput())
         
        switch option {
        case .anagram:
          consoleIO.write("Type the first string:")
          let arg1 = consoleIO.getInput()
          consoleIO.write("Type the second string:")
          let arg2 = consoleIO.getInput()
            
          consoleIO.write("\(arg2) \(isOrNot(arg1.isAnagramOf(arg2))) an anagram of \(arg1)")
            
        case .palindrome:
          consoleIO.write("Type a word or sentence:")
          let arg = consoleIO.getInput()
          consoleIO.write("\(arg) \(isOrNot(arg.isPalindrome())) a palindrome")
            
        case .quit:
          shouldQuit = true
            
        default:
            badMode(value)
        }
      }
    }

    func getOption(_ option: String) -> (option:OptionType, value: String) {
        return (OptionType(value: option), option)
    }

}
