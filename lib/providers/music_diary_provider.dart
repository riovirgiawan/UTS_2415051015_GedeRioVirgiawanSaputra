
import 'package:flutter/foundation.dart';

import '../models/music_diary_entry.dart';
import '../repositories/diary_repository.dart';

class MusicDiaryProvider extends ChangeNotifier {
  final DiaryRepository repository;

  MusicDiaryProvider(this.repository);

  final List<MusicDiaryEntry> _entries = [];

  List<MusicDiaryEntry> get entries => _entries;

  bool isSaving = false;
  String? error;

  Future<bool> addEntry(MusicDiaryEntry entry) async {
    isSaving = true;
    error = null;
    notifyListeners();

    try {
      final savedEntry = await repository.createEntry(entry);

      _entries.insert(0, savedEntry);

      isSaving = false;
      notifyListeners();

      return true;
    } catch (e) {
      error = e.toString();
      isSaving = false;
      notifyListeners();

      return false;
    }
  }
}
