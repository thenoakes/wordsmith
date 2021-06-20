import 'ConsoleIO.dart';
import 'String_extensions.dart';

enum OptionType { palindrome, anagram, help, unknown, quit }

OptionType toOptionType(String mode) {
  switch (mode) {
    case 'p':
      return OptionType.palindrome;
    case 'a':
      return OptionType.anagram;
    case 'h':
      return OptionType.help;
    case 'q':
      return OptionType.quit;
    default:
      return OptionType.unknown;
  }
}

class Panagram {
  final consoleIO = ConsoleIO();

  void badArgs(bool tooMany, String option) {
    consoleIO.write(
        "Too ${tooMany ? "many" : "few"} arguments for option $option",
        to: OutputType.error);
    consoleIO.printUsage();
  }

  void badMode(String mode) {
    consoleIO.write('Unknown option $mode', to: OutputType.error);
  }

  String isOrNot(bool ifTrue) {
    return "is${ifTrue ? "" : " not"}";
  }

  void staticMode(List<String> args) {
    final argCount = args.length;
    final modeArg = argCount > 0 ? args.first : '-';

    final value = modeArg.substring(1);

    var option = toOptionType(value);

    switch (option) {
      case OptionType.anagram:
        if (argCount != 3) {
          badArgs(argCount > 3, value);
        } else {
          final arg1 = args[1];
          final arg2 = args[2];
          consoleIO.write(
              '$arg2 ${isOrNot(arg1.isAnagramOf(arg2))} an anagram of $arg1');
        }
        break;

      case OptionType.palindrome:
        if (argCount != 2) {
          badArgs(argCount > 3, value);
        } else {
          final arg = args[1];
          consoleIO.write('$arg ${isOrNot(arg.isPalindrome())} a palindrome');
        }
        break;

      case OptionType.help:
        consoleIO.printUsage();
        break;

      default:
        badMode(value);
        consoleIO.printUsage();
    }
  }

  void interactiveMode() {
    consoleIO.write(
        'Welcome to Panagram. This program checks if an input string is an anagram or palindrome.');

    var shouldQuit = false;
    while (!shouldQuit) {
      consoleIO.write(
          "Type 'a' to check for anagrams or 'p' for palindromes type 'q' to quit.");

      final mode = getOption(consoleIO.getInput());
      final OptionType option = mode[0];
      final String value = mode[1];

      switch (option) {
        case OptionType.anagram:
          consoleIO.write('Type the first string:');
          final arg1 = consoleIO.getInput();
          consoleIO.write('Type the second string:');
          final arg2 = consoleIO.getInput();

          consoleIO.write(
              '$arg2 ${isOrNot(arg1.isAnagramOf(arg2))} an anagram of $arg1');
          break;

        case OptionType.palindrome:
          consoleIO.write('Type a word or sentence:');
          final arg = consoleIO.getInput();
          consoleIO.write('$arg ${isOrNot(arg.isPalindrome())} a palindrome');
          break;

        case OptionType.quit:
          shouldQuit = true;
          break;

        default:
          badMode(value);
      }
    }
  }

  List getOption(String option) {
    return [toOptionType(option), option];
  }

}
