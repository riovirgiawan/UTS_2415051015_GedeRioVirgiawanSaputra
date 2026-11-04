
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MelodyLogApp());
}

class MelodyLogApp extends StatelessWidget {
  const MelodyLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MelodyLog',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const ThemePreviewScreen(),
    );
  }
}

class ThemePreviewScreen extends StatelessWidget {
  const ThemePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MelodyLog'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.music_note_rounded,
                size: 80,
                color: AppTheme.primaryColor,
              ),

              const SizedBox(height: 16),

              Text(
                'MelodyLog',
                style: Theme.of(context).textTheme.headlineLarge,
              ),

              const SizedBox(height: 8),

              Text(
                'Your Music, Your Memories',
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 32),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.headphones_rounded,
                        size: 40,
                      ),

                      const SizedBox(height: 12),

                      Text(
                        'Welcome to MelodyLog',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Simpan cerita dan kenangan '
                        'di balik musik yang kamu dengarkan.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),

                      const SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Get Started'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
