import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/music_diary_entry.dart';
import '../providers/music_diary_provider.dart';
import 'edit_diary_screen.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<MusicDiaryProvider>().fetchEntries();
      }
    });
  }

  Future<void> _openEditScreen(MusicDiaryEntry entry) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditDiaryScreen(entry: entry),
      ),
    );
  }

  Future<void> _confirmDelete(MusicDiaryEntry entry) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Diary Entry?'),
          content: Text(
            'Are you sure you want to delete '
            '"${entry.trackName}" from your diary?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !mounted) {
      return;
    }

    final provider = context.read<MusicDiaryProvider>();
    final success = await provider.deleteEntry(entry.id);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? 'Diary entry deleted successfully!'
              : provider.error ?? 'Failed to delete diary entry.',
        ),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Diary'),
      ),
      body: Consumer<MusicDiaryProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.entries.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.error != null && provider.entries.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                    ),
                    const SizedBox(height: 12),
                    const Text('Failed to load diary entries.'),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: provider.fetchEntries,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (provider.entries.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.library_music_outlined,
                      size: 60,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Your diary is empty',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Explore songs and add them to your diary.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return Column(
            children: [
              // Error banner jika refresh gagal
              if (provider.error != null)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Failed to refresh diary entries.',
                        ),
                      ),
                      TextButton(
                        onPressed: provider.isLoading
                            ? null
                            : provider.fetchEntries,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),

              // Diary list
              Expanded(
                child: RefreshIndicator(
                  onRefresh: provider.fetchEntries,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: provider.entries.length,
                    itemBuilder: (context, index) {
                      final entry = provider.entries[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: entry.artworkUrl != null
                                ? Image.network(
                                    entry.artworkUrl!,
                                    width: 55,
                                    height: 55,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, _, _) {
                                      return _placeholder();
                                    },
                                  )
                                : _placeholder(),
                          ),
                          title: Text(
                            entry.trackName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(entry.artistName),
                              const SizedBox(height: 4),
                              Text(
                                '${entry.mood} • ${entry.rating}/5 stars',
                              ),
                              Text(
                                '${entry.listenedAt.day}/'
                                '${entry.listenedAt.month}/'
                                '${entry.listenedAt.year}',
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                tooltip: 'Edit diary',
                                icon: const Icon(Icons.edit_outlined),
                                onPressed: () => _openEditScreen(entry),
                              ),
                              IconButton(
                                tooltip: 'Delete diary',
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                                onPressed: provider.isDeleting
                                    ? null
                                    : () => _confirmDelete(entry),
                              ),
                            ],
                          ),
                          onTap: () => _openEditScreen(entry),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 55,
      height: 55,
      color: const Color(0xFF211C2B),
      child: const Icon(Icons.music_note),
    );
  }
}