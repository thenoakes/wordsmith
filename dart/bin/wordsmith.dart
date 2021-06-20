import 'package:wordsmith/Panagram.dart';

void main(List<String> arguments) {
  final argCount = arguments.length;

  final panagram = Panagram();

  if (argCount < 1) {
    panagram.interactiveMode();
  } else {
    panagram.staticMode(arguments);
  }
}
