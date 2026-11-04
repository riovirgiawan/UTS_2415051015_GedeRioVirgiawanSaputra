
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SongDetailScreen extends StatelessWidget {
  final String title;
  final String artist;
  final String album;
  final String genre;
  final String duration;
  final IconData icon;

  const SongDetailScreen({
    super.key,
    required this.title,
    required this.artist,
    required this.album,
    required this.genre,
    required this.duration,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Song Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // Placeholder artwork lagu
                Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF302442),
                        Color(0xFF9B7EDE),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(
                    icon,
                    size: 100,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 28),

                // Judul lagu
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                const SizedBox(height: 8),

                // Nama artis
                Text(
                  artist,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.accentColor,
                      ),
                ),

                const SizedBox(height: 28),

                // Informasi lagu
                Card(
                  child: Column(
                    children: [
                      _buildInfoTile(
                        icon: Icons.album_rounded,
                        label: 'Album',
                        value: album,
                      ),
                      const Divider(height: 1),
                      _buildInfoTile(
                        icon: Icons.music_note_rounded,
                        label: 'Genre',
                        value: genre,
                      ),
                      const Divider(height: 1),
                      _buildInfoTile(
                        icon: Icons.access_time_rounded,
                        label: 'Duration',
                        value: duration,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // Tombol menuju fitur pencatatan
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Add to Diary will be available in a later stage.',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.bookmark_add_rounded),
                    label: const Text('Add to Diary'),
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  'Keep this song and its memories in your music diary.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppTheme.accentColor,
      ),
      title: Text(
        label,
        style: const TextStyle(
          color: AppTheme.secondaryTextColor,
          fontSize: 12,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          color: AppTheme.textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
