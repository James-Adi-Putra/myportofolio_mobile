import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/screens/menu.dart';

void main() {
  testWidgets('InfoCard displays title and content correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: InfoCard(title: 'NPM', content: '2506624644'),
        ),
      ),
    );

    expect(find.text('NPM'), findsOneWidget);
    expect(find.text('2506624644'), findsOneWidget);
  });
}
