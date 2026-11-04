
import 'package:flutter_test/flutter_test.dart';
import 'package:melody_log/main.dart';

void main() {
  testWidgets('MelodyLog navigation works correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MelodyLogApp());

    // Memastikan halaman Home tampil pertama kali
    expect(find.text('Your Music Overview'), findsOneWidget);
    expect(find.text('Recent Activity'), findsOneWidget);

    // Berpindah ke Explore
    await tester.tap(find.text('Explore'));
    await tester.pumpAndSettle();

    expect(find.text('Discover Your Music'), findsOneWidget);

    // Berpindah ke My Diary
    await tester.tap(find.text('My Diary'));
    await tester.pumpAndSettle();

    expect(find.text('Your Music Diary'), findsOneWidget);

    // Berpindah ke Profile
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    expect(find.text('MelodyLog User'), findsOneWidget);

    // Kembali ke Home
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(find.text('Your Music Overview'), findsOneWidget);
  });
}
