
import 'package:flutter_test/flutter_test.dart';
import 'package:melody_log/main.dart';

void main() {
  testWidgets('MelodyLog app displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MelodyLogApp());

    expect(find.text('MelodyLog'), findsWidgets);
    expect(find.text('Your Music, Your Memories'), findsOneWidget);
    expect(find.text('Welcome to MelodyLog'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });
}