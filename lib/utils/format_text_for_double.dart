/// Format text for double value
/// 1.0 -> 1
/// 1.1 -> 1.1
/// 1.10 -> 1.1
/// 1.101 -> 1.101
String formatTextForDouble(double value) {
  final string = value.toString();
  return string.replaceFirst(RegExp(r'(\.0+|(?<=[.])[0-9]*0+$)'), '');
}
