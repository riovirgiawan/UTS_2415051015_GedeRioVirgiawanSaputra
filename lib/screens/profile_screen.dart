
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 48,
                    backgroundColor: Color(0xFF211C2B),
                    child: Icon(
                      Icons.person_rounded,
                      size: 52,
                      color: Color(0xFFC7B5F5),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'MelodyLog User',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your Music, Your Memories',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  const Card(
                    child: ListTile(
                      leading: Icon(Icons.music_note_rounded),
                      title: Text('MelodyLog'),
                      subtitle: Text('Music Diary Application'),
                    ),
                  ),
                  const Card(
                    child: ListTile(
                      leading: Icon(Icons.info_outline_rounded),
                      title: Text('Application Version'),
                      subtitle: Text('1.0.0'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
