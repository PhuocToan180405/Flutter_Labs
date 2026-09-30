import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab2_micard/main.dart';

void main() {
  testWidgets('MiCard renders personal details, avatar and contact info', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    // Verify name and title
    expect(find.text('ThinkPad E14'), findsOneWidget);
    expect(find.text('FLUTTER DEVELOPER'), findsOneWidget);

    // Verify contact information
    expect(find.text('+84 394 281 107'), findsOneWidget);
    expect(find.text('flutter.developer@gmail.com'), findsOneWidget);

    // Verify Cards and ListTiles
    expect(find.byType(Card), findsNWidgets(2));
    expect(find.byType(ListTile), findsNWidgets(2));

    // Verify Avatar
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    // Verify Cupertino Icons
    expect(find.byIcon(CupertinoIcons.phone_fill), findsOneWidget);
    expect(find.byIcon(CupertinoIcons.mail_solid), findsOneWidget);
  });
}
