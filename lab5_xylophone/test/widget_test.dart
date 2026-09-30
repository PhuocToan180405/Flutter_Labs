import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab5_xylophone/main.dart';

void main() {
  testWidgets('Xylophone app displays 7 keys', (WidgetTester tester) async {
    await tester.pumpWidget(const XylophoneApp());

    // Kiểm tra có đúng 7 phím đàn TextButton
    expect(find.byType(TextButton), findsNWidgets(7));
  });
}
