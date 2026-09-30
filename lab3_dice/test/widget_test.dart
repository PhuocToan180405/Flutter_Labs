import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab3_dice/main.dart';

void main() {
  testWidgets('DiceApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const DiceApp());

    // Verify AppBar title is present
    expect(find.text('Dice'), findsOneWidget);

    // Verify two dice images are present
    expect(find.byType(Image), findsNWidgets(2));

    // Tap on the first dice (TextButton)
    await tester.tap(find.byType(TextButton).first);
    await tester.pump();

    // Verify app continues to display
    expect(find.text('Dice'), findsOneWidget);
  });
}
