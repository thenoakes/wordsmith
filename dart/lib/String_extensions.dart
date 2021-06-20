import 'package:collection/collection.dart';

String normalise(String input) {
  return input.toLowerCase().replaceAll(' ', '');
}

List<int> toCharArray(String input) {
  return List<int>.from(normalise(input).codeUnits)..sort((a, b) => b - a);
}

extension Panagram on String {
  bool isPalindrome() {
    final forward = normalise(this);
    final reverse = String.fromCharCodes(forward.codeUnits.reversed);
    return forward == reverse;
  }

  bool isAnagramOf(String s) {
      return IterableEquality().equals(toCharArray(this), toCharArray(s));
  }
}
