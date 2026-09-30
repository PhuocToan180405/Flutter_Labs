import 'package:flutter_test/flutter_test.dart';
import 'package:lab7_destini/main.dart';

void main() {
  testWidgets('Destini app loads story smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const DestiniApp());

    // Verify that the first story text is loaded
    expect(find.textContaining('Xe của bạn bị xẹp lốp'), findsOneWidget);

    // Verify that choice buttons are present
    expect(find.textContaining('Đồng ý đi nhờ'), findsOneWidget);
    expect(find.textContaining('Khoan đã'), findsOneWidget);
  });
}
