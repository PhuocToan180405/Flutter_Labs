import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab1_iamrich/main.dart';

void main() {
  testWidgets('I Am Rich app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the title 'I Am Rich' is displayed.
    expect(find.text('I Am Rich'), findsOneWidget);

    // Verify that the Image widget is present.
    expect(find.byType(Image), findsOneWidget);
  });
}
