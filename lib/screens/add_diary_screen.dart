import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/music_diary_entry.dart';
import '../models/song.dart';
import '../providers/music_diary_provider.dart';

class AddDiaryScreen extends StatefulWidget {
  final Song song;

  const AddDiaryScreen({
    super.key,
    required this.song,
  });

  @override
  State<AddDiaryScreen> createState() => _AddDiaryScreenState();
}

class _AddDiaryScreenState extends State<AddDiaryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _noteController = TextEditingController();

  DateTime _listenedAt = DateTime.now();
  String? _selectedMood;
  int _rating = 0;

  final List<String> _moods = [
    'Happy',
    'Relaxed',
    'Sad',
    'Energetic',
    'Nostalgic',
    'Focused',
  ];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _listenedAt,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        _listenedAt = selectedDate;
      });
    }
  }

  Future<void> _saveDiary() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validasi mood
    if (_selectedMood == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan pilih mood terlebih dahulu.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Validasi rating
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan berikan rating terlebih dahulu.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final entry = MusicDiaryEntry(
      id: '',
      trackId: widget.song.trackId,
      trackName: widget.song.trackName,
      artistName: widget.song.artistName,
      albumName: widget.song.albumName,
      artworkUrl: widget.song.artworkUrl,
      listenedAt: _listenedAt,
      mood: _selectedMood!,
      rating: _rating,
      note: _noteController.text.trim(),
    );

    final provider = context.read<MusicDiaryProvider>();
    final success = await provider.addEntry(entry);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Diary entry saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            provider.error ?? 'Failed to save diary entry.',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSaving = context.watch<MusicDiaryProvider>().isSaving;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add to Diary'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: widget.song.artworkUrl != null
                          ? Image.network(
                              widget.song.artworkUrl!,
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) {
                                return _artworkPlaceholder();
                              },
                            )
                          : _artworkPlaceholder(),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.song.trackName,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.song.artistName,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          if (widget.song.albumName != null)
                            Text(
                              widget.song.albumName!,
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Text(
                  'Listening Date',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: _selectDate,
                  icon: const Icon(Icons.calendar_month),
                  label: Text(
                    '${_listenedAt.day}/'
                    '${_listenedAt.month}/'
                    '${_listenedAt.year}',
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'How did you feel?',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _moods.map((mood) {
                    return ChoiceChip(
                      label: Text(mood),
                      selected: _selectedMood == mood,
                      onSelected: (selected) {
                        setState(() {
                          _selectedMood = selected ? mood : null;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                Text(
                  'Your Rating',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                Row(
                  children: List.generate(5, (index) {
                    final starNumber = index + 1;

                    return IconButton(
                      onPressed: () {
                        setState(() {
                          _rating = starNumber;
                        });
                      },
                      icon: Icon(
                        starNumber <= _rating
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 34,
                      ),
                    );
                  }),
                ),
                Text(
                  _rating == 0
                      ? 'Select your rating'
                      : '$_rating out of 5 stars',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 24),
                Text(
                  'Personal Note',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _noteController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Write about your listening experience...',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please write a short personal note.';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: isSaving ? null : _saveDiary,
                    icon: isSaving
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(Icons.save),
                    label: Text(
                      isSaving ? 'Saving...' : 'Save to My Diary',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _artworkPlaceholder() {
    return Container(
      width: 90,
      height: 90,
      color: const Color(0xFF211C2B),
      child: const Icon(
        Icons.music_note,
        size: 40,
      ),
    );
  }
}
