import 'package:flutter_test/flutter_test.dart';
import 'package:lab6_quizzler/main.dart';

void main() {
  testWidgets('Quizzler smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const QuizzlerApp());

    // Verify question and answer buttons are present.
    expect(find.text('Việt Nam có đường biên giới với Campuchia.'), findsOneWidget);
    expect(find.text('Đúng'), findsOneWidget);
    expect(find.text('Sai'), findsOneWidget);

    // Tap 'Đúng' button.
    await tester.tap(find.text('Đúng'));
    await tester.pump();

    // Verify that the next question is displayed.
    expect(find.text('Thủ đô của Việt Nam là Thành phố Hồ Chí Minh.'), findsOneWidget);
  });
}
