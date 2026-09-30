import 'package:flutter_test/flutter_test.dart';
import 'package:lab3_dice/main.dart';

void main() {
  testWidgets('DiceApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const DiceApp());

    // Verify AppBar title is present
    expect(find.text('Dice'), findsOneWidget);

    // Verify 'Lắc xúc xắc' button is present
    expect(find.text('Lắc xúc xắc'), findsOneWidget);

    // Tap the 'Lắc xúc xắc' button
    await tester.tap(find.text('Lắc xúc xắc'));
    await tester.pump();

    // Verify widget still builds and functions without error
    expect(find.text('Dice'), findsOneWidget);
  });
}
