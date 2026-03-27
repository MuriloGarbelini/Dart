// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:int_flutter/main.dart';

void main() {
  testWidgets('Counter increments and decrements', (WidgetTester tester) async {
    await tester.pumpWidget(const MeuMaterialApp());

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
    expect(find.text('-'), findsOneWidget);
    expect(find.text('+'), findsOneWidget);

    await tester.tap(find.text('+'));
    await tester.pump();
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.text('-'));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
  });
}
