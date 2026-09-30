import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab4_magic_8_ball/main.dart';

void main() {
  testWidgets('Magic 8 Ball app smoke and interaction test', (WidgetTester tester) async {
    // Build app
    await tester.pumpWidget(const MyApp());

    // Verify AppBar title is present
    expect(find.text('Ask Me Anything'), findsOneWidget);

    // Verify 'Nhận câu trả lời' button is present
    expect(find.text('Nhận câu trả lời'), findsOneWidget);

    // Verify Ball Image widget is present
    expect(find.byType(Image), findsOneWidget);

    // Tap the button and trigger frame
    await tester.tap(find.text('Nhận câu trả lời'));
    await tester.pump();

    // Verify app remains functional
    expect(find.byType(Image), findsOneWidget);
  });
}
