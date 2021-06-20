import 'dart:convert';
import 'dart:io';
import 'package:args/args.dart';

enum OutputType { error, standard }

class ConsoleIO {
  final parser = ArgParser();

  void write(String message, {OutputType to = OutputType.standard}) {
    switch (to) {
      case OutputType.standard:
        stdout.writeln('\u{001B}[;m$message');
        break;
      case OutputType.error:
        stderr.writeln('\u{001B}[0;31m$message');
    }
  }

  void printUsage() {
    var executableName = Platform.script.pathSegments.last;
    write('usage:');
    write('$executableName -a string1 string2');
    write('or');
    write('$executableName -p string');
    write('or');
    write('$executableName -h to show usage information');
    write('Type $executableName without an option to enter interactive mode.');
  }

  String getInput() {
    var line = stdin.readLineSync(encoding: Encoding.getByName('utf-8')!);
    return line?.trim() ?? '';
  }
}
