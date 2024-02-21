// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:example/utils/format_text_for_double.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('format_text_for_double', () {
    expect(formatTextForDouble(30), '30');
    expect(formatTextForDouble(100), '100');
    expect(formatTextForDouble(100.0), '100');
    expect(formatTextForDouble(100.1), '100.1');
    expect(formatTextForDouble(100.10), '100.1');
    expect(formatTextForDouble(100.100), '100.1');
    expect(formatTextForDouble(100.123), '100.123');
    expect(formatTextForDouble(100.123456789), '100.123456789');
    expect(formatTextForDouble(100.12003), '100.12003');
  });
}
