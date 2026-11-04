
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'providers/song_provider.dart';
import 'providers/music_diary_provider.dart';
import 'repositories/song_repository.dart';
import 'repositories/diary_repository.dart';
import 'screens/main_screen.dart';
import 'services/song_service.dart';
import 'services/diary_service.dart';
import 'services/supabase_config.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!SupabaseConfig.isConfigured) {
    throw Exception(
      'Supabase configuration is missing. '
      'Run the app with supabase_config.json.',
    );
  }

  await Supabase.initialize(
    url: SupabaseConfig.url,
    publishableKey: SupabaseConfig.publishableKey,
  );

  runApp(const MelodyLogApp());
}

class MelodyLogApp extends StatelessWidget {
  const MelodyLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SongProvider(
            SongRepository(
              SongService(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => MusicDiaryProvider(
            DiaryRepository(
              DiaryService(
                Supabase.instance.client,
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'MelodyLog',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const MainScreen(),
      ),
    );
  }
}
