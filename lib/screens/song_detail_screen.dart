import 'package:flutter/material.dart';

import '../models/song.dart';
import 'add_diary_screen.dart';

class SongDetailScreen extends StatelessWidget {
  final Song song;

  const SongDetailScreen({
    super.key,
    required this.song,
  });

  void _openAddDiary(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddDiaryScreen(song: song),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Song Detail'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: SizedBox(
                    width: 230,
                    height: 230,
                    child: song.artworkUrl != null
                        ? Image.network(
                            song.artworkUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) {
                              return _artworkPlaceholder();
                            },
                          )
                        : _artworkPlaceholder(),
                  ),
                ),

                const SizedBox(height: 28),

                Text(
                  song.trackName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),

                const SizedBox(height: 8),

                Text(
                  song.artistName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                const SizedBox(height: 24),

                _detailRow('Album', song.albumName ?? '-'),
                _detailRow('Genre', song.genre ?? '-'),
                _detailRow('Duration', song.formattedDuration),

                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () => _openAddDiary(context),
                    icon: const Icon(Icons.bookmark_add),
                    label: const Text('Add to Diary'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFA9A2B5),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _artworkPlaceholder() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFF211C2B),
      child: const Icon(
        Icons.music_note,
        size: 80,
      ),
    );
  }
}