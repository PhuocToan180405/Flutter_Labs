import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab8_bmi_calculator/calculator_brain.dart';
import 'package:lab8_bmi_calculator/main.dart';
import 'package:lab8_bmi_calculator/screens/results_page.dart';

void main() {
  group('CalculatorBrain Unit Tests', () {
    test('Calculates normal BMI correctly', () {
      final calc = CalculatorBrain(height: 180, weight: 70);
      expect(calc.calculateBMI(), '21.6');
      expect(calc.getResult(), 'Normal');
      expect(calc.getInterpretation(), 'You have a normal body weight. Good job!');
    });

    test('Calculates overweight BMI correctly', () {
      final calc = CalculatorBrain(height: 170, weight: 80);
      expect(calc.calculateBMI(), '27.7');
      expect(calc.getResult(), 'Overweight');
      expect(calc.getInterpretation(), 'You have a higher than normal body weight. Try to exercise more.');
    });

    test('Calculates underweight BMI correctly', () {
      final calc = CalculatorBrain(height: 190, weight: 60);
      expect(calc.calculateBMI(), '16.6');
      expect(calc.getResult(), 'Underweight');
      expect(calc.getInterpretation(), 'You have a lower than normal body weight. You can eat a bit more.');
    });
  });

  group('BMI Calculator UI & Flow Tests', () {
    testWidgets('Full smoke test and navigation to results and back', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const BMICalculator());

      // Check initial values
      expect(find.text('BMI CALCULATOR'), findsOneWidget);
      expect(find.text('MALE'), findsOneWidget);
      expect(find.text('FEMALE'), findsOneWidget);
      expect(find.text('HEIGHT'), findsOneWidget);
      expect(find.text('190'), findsOneWidget);
      expect(find.text('WEIGHT'), findsOneWidget);
      expect(find.text('60'), findsOneWidget);
      expect(find.text('AGE'), findsOneWidget);
      expect(find.text('30'), findsOneWidget);
      expect(find.text('CALCULATE'), findsOneWidget);

      // Select Male
      await tester.tap(find.text('MALE'));
      await tester.pump();

      // Tap + on weight
      final addButtons = find.byIcon(Icons.add);
      await tester.tap(addButtons.first);
      await tester.pump();
      expect(find.text('61'), findsOneWidget);

      // Tap - on weight to return to 60
      final removeButtons = find.byIcon(Icons.remove);
      await tester.tap(removeButtons.first);
      await tester.pump();
      expect(find.text('60'), findsOneWidget);

      // Tap CALCULATE button
      await tester.tap(find.text('CALCULATE'));
      await tester.pumpAndSettle();

      // On ResultsPage
      expect(find.byType(ResultsPage), findsOneWidget);
      expect(find.text('Your Result'), findsOneWidget);
      expect(find.text('16.6'), findsOneWidget);
      expect(find.text('UNDERWEIGHT'), findsOneWidget);
      expect(find.text('RE-CALCULATE'), findsOneWidget);

      // Tap RE-CALCULATE to pop back
      await tester.tap(find.text('RE-CALCULATE'));
      await tester.pumpAndSettle();

      // Back on InputPage
      expect(find.byType(ResultsPage), findsNothing);
      expect(find.text('CALCULATE'), findsOneWidget);
    });
  });
}
