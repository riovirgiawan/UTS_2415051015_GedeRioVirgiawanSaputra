
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
                children: [
                  // Avatar
                  const CircleAvatar(
                    radius: 55,
                    backgroundColor: Color(0xFF211C2B),
                    child: Icon(
                      Icons.person_rounded,
                      size: 65,
                      color: Color(0xFFC7B5F5),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Identitas mahasiswa
                  Text(
                    'Gede Rio Virgiawan Saputra',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'NIM: 2415051015',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Kelas: PTI 5C',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Pendidikan Teknik Informatika',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),

                  const SizedBox(height: 28),

                  // Informasi aplikasi
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Application Information',
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),

                  const SizedBox(height: 12),

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

                  const Card(
                    child: ListTile(
                      leading: Icon(Icons.school_outlined),
                      title: Text('Developed for'),
                      subtitle: Text(
                        'Universitas Pendidikan Ganesha',
                      ),
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
