import 'package:flutter_test/flutter_test.dart';
import 'package:lab9_clima/main.dart';

void main() {
  testWidgets('WeatherApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const WeatherApp());

    // Verify that the Weather App title is present.
    expect(find.text('Weather App'), findsOneWidget);
  });
}
