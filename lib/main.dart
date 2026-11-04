import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/song_provider.dart';
import 'repositories/song_repository.dart';
import 'screens/main_screen.dart';
import 'services/song_service.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MelodyLogApp());
}

class MelodyLogApp extends StatelessWidget {
  const MelodyLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SongProvider(
        SongRepository(
          SongService(),
        ),
      ),
      child: MaterialApp(
        title: 'MelodyLog',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const MainScreen(),
      ),
    );
  }
}