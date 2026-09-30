import 'package:flutter_test/flutter_test.dart';
import 'package:lab9_clima/main.dart';

void main() {
  testWidgets('WeatherApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const WeatherApp());

    expect(find.text('Weather App'), findsOneWidget);
  });
}
