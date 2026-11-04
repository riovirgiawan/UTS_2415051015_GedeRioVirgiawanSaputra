
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:melody_log/main.dart';

void main() {
  testWidgets('MelodyLog navigation and music discovery work correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MelodyLogApp());

    // Memastikan Home tampil
    expect(find.text('Your Music Overview'), findsOneWidget);

    // Membuka Explore
    await tester.tap(find.text('Explore'));
    await tester.pumpAndSettle();

    expect(find.text('Discover Your Music'), findsOneWidget);
    expect(find.text('Popular Songs'), findsOneWidget);
    expect(find.text('Cruel Summer'), findsOneWidget);

    // Membuka detail lagu
    await tester.tap(find.text('Cruel Summer'));
    await tester.pumpAndSettle();

    expect(find.text('Song Details'), findsOneWidget);
    expect(find.text('Taylor Swift'), findsOneWidget);
    expect(find.text('Lover'), findsOneWidget);
    expect(find.text('Add to Diary'), findsOneWidget);

    // Kembali ke Explore
    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Discover Your Music'), findsOneWidget);

    // Menguji pencarian lagu
    await tester.enterText(
      find.byType(TextField),
      'Billie Eilish',
    );
    await tester.pumpAndSettle();

    expect(find.text('Birds of a Feather'), findsOneWidget);
    expect(find.text('Cruel Summer'), findsNothing);

    // Menguji hasil pencarian kosong
    await tester.enterText(
      find.byType(TextField),
      'Lagu Tidak Ada',
    );
    await tester.pumpAndSettle();

    expect(find.text('No Songs Found'), findsOneWidget);
  });
}
