
import 'package:flutter_test/flutter_test.dart';
import 'package:melody_log/main.dart';

void main() {
  testWidgets('MelodyLog home dashboard displays correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MelodyLogApp());

    expect(find.text('MelodyLog'), findsOneWidget);
    expect(find.text('Your Music Overview'), findsOneWidget);
    expect(find.text('Your Listening Mood'), findsOneWidget);
    expect(find.text('Recent Activity'), findsOneWidget);
    expect(find.text('Cruel Summer'), findsOneWidget);
    expect(find.text('Explore Music'), findsOneWidget);
  });
}
