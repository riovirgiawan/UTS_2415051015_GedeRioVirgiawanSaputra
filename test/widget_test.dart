import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:melody_log/main.dart';

void main() {
  testWidgets('MelodyLog can navigate to Explore screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MelodyLogApp());

    expect(find.text('Your Music Overview'), findsOneWidget);

    await tester.tap(find.text('Explore').first);
    await tester.pumpAndSettle();

    expect(find.text('Discover Your Music'), findsOneWidget);
    expect(find.text('Search Results'), findsOneWidget);
    expect(find.text('Start Exploring Music'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });
}