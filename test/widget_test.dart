
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:melody_log/providers/song_provider.dart';
import 'package:melody_log/providers/music_diary_provider.dart';
import 'package:melody_log/repositories/song_repository.dart';
import 'package:melody_log/repositories/diary_repository.dart';
import 'package:melody_log/services/song_service.dart';
import 'package:melody_log/services/diary_service.dart';
import 'package:melody_log/screens/main_screen.dart';
import 'package:melody_log/theme/app_theme.dart';

void main() {
  testWidgets('MelodyLog can display Home screen', (tester) async {
    final testSupabaseClient = SupabaseClient(
      'http://localhost:54321',
      'test-key',
    );
    
    testSupabaseClient.auth.stopAutoRefresh();

    final songProvider = SongProvider(
      SongRepository(
        SongService(),
      ),
    );

    final diaryProvider = MusicDiaryProvider(
      DiaryRepository(
        DiaryService(testSupabaseClient),
      ),
    );

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: songProvider,
          ),
          ChangeNotifierProvider.value(
            value: diaryProvider,
          ),
        ],
        child: MaterialApp(
          title: 'MelodyLog',
          theme: AppTheme.darkTheme,
          home: const MainScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Your Music Overview'), findsOneWidget);
  });
}
