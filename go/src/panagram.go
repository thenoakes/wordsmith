package main

import "os"

type OptionType string 

const (
	Palindrome OptionType = "PALINDROME"
	Anagram = "ANAGRAM"
	Help = "HELP"
	Quit = "QUIT"
	Unknown = ""
)

func toOptionType(mode string) OptionType {
	switch mode {
		case "p": return Palindrome;
		case "a": return Anagram;
		case "h": return Help;
		case "q": return Quit;
		default: return Unknown;
	}
}

type Panagram struct {
	consoleIO ConsoleIO
}

func NewPanagram() *Panagram {
	return &Panagram{}
}

func (p *Panagram) BadArgs(tooMany bool, option string) {
	msg := "Too "
	if tooMany {
		msg += "many"
	} else {
		msg += "few"
	}
	msg += " arguments for option " + option
	p.consoleIO.WriteStderr(msg)
}

func (p *Panagram) BadMode(mode string) {
	p.consoleIO.WriteStderr("Unknown option " + mode)
}

func isOrNot(ifTrue bool) string {
	txt := "is"
	if !ifTrue {
		txt += " not"
	}
	return txt
}

func (p *Panagram) StaticMode() {
	var argCount = len(os.Args)

	// CAUTION this will not work for mult-byte characters
	var modeArg = os.Args[1]
	var mode = modeArg[1:]

	var option = toOptionType(mode);

	switch option {
	case Anagram:
		if (argCount != 4) {
			p.BadArgs(argCount > 4, mode)
		} else {
			var arg1 = os.Args[2]
			var arg2 = os.Args[3]
			p.consoleIO.WriteStdout(arg2 + " " + isOrNot(AreAnagrams(arg1, arg2)) + " an anargram of " + arg1)
		}
		break;
	case Palindrome:
		if argCount != 3 {
			p.BadArgs(argCount > 3, mode)
		} else {
			var arg = os.Args[2]
			p.consoleIO.WriteStdout(arg + " " + isOrNot(IsPalindrome(arg)) + " a palindrome")
		}
		break;
	case Help:
		p.consoleIO.PrintUsage()
		break;
	default:
		p.BadMode(mode)
		p.consoleIO.PrintUsage()
	}

	// p.consoleIO.WriteStdout("You supplied mode " + mode)
}

func (p *Panagram) InteractiveMode() {
	p.consoleIO.WriteStdout("Welcome to Panagram. This program checks if an input string is an anagram or palindrome.")

	var shouldQuit = false;
	for; !shouldQuit; {
		p.consoleIO.WriteStdout("Type 'a' to check for anagrams or 'p' for palindromes type 'q' to quit.")

		var input = p.consoleIO.GetInput()
		var mode = toOptionType(input)

		switch mode {
		case Anagram:
			p.consoleIO.WriteStdout("Type the first string:");
			var arg1 = p.consoleIO.GetInput();
			p.consoleIO.WriteStdout("Type the second string:");
			var arg2 = p.consoleIO.GetInput();

			p.consoleIO.WriteStdout(
					arg2 + " " + isOrNot(AreAnagrams(arg1, arg2)) + " an anagram of " + arg1)
			break;
			case Palindrome:
				p.consoleIO.WriteStdout("Type a word or sentence:")
				var arg = p.consoleIO.GetInput()
				p.consoleIO.WriteStdout(arg + " " + isOrNot(IsPalindrome(arg)) + " a palindrome")
				break;
			case Quit:
				shouldQuit = true
				break;
			default:
				p.BadMode(input)
		}
	} 

}

