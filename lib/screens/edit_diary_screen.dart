
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/music_diary_entry.dart';
import '../providers/music_diary_provider.dart';

class EditDiaryScreen extends StatefulWidget {
  final MusicDiaryEntry entry;

  const EditDiaryScreen({
    super.key,
    required this.entry,
  });

  @override
  State<EditDiaryScreen> createState() => _EditDiaryScreenState();
}

class _EditDiaryScreenState extends State<EditDiaryScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _noteController;

  late DateTime _listenedAt;
  late String _selectedMood;
  late int _rating;

  final List<String> _moods = [
    'Happy',
    'Relaxed',
    'Sad',
    'Energetic',
    'Nostalgic',
    'Focused',
  ];

  @override
  void initState() {
    super.initState();

    _noteController = TextEditingController(
      text: widget.entry.note,
    );

    _listenedAt = widget.entry.listenedAt;
    _selectedMood = widget.entry.mood;
    _rating = widget.entry.rating;
  }

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

  Future<void> _updateDiary() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final updatedEntry = MusicDiaryEntry(
      id: widget.entry.id,
      trackId: widget.entry.trackId,
      trackName: widget.entry.trackName,
      artistName: widget.entry.artistName,
      albumName: widget.entry.albumName,
      artworkUrl: widget.entry.artworkUrl,
      listenedAt: _listenedAt,
      mood: _selectedMood,
      rating: _rating,
      note: _noteController.text.trim(),
    );

    final provider = context.read<MusicDiaryProvider>();

    final success = await provider.updateEntry(updatedEntry);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Diary entry updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            provider.error ?? 'Failed to update diary entry.',
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
        title: const Text('Edit Diary'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  widget.entry.trackName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 6),
                Text(widget.entry.artistName),

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
                        if (selected) {
                          setState(() {
                            _selectedMood = mood;
                          });
                        }
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
                  '$_rating out of 5 stars',
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
                    onPressed: isSaving ? null : _updateDiary,
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
                      isSaving ? 'Updating...' : 'Update Diary',
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
}
