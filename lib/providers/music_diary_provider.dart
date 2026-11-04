
import 'package:flutter/foundation.dart';

import '../models/music_diary_entry.dart';
import '../repositories/diary_repository.dart';

class MusicDiaryProvider extends ChangeNotifier {
  final DiaryRepository repository;

  MusicDiaryProvider(this.repository);

  final List<MusicDiaryEntry> _entries = [];

  List<MusicDiaryEntry> get entries => _entries;

  bool isLoading = false;
  bool isSaving = false;
  bool isDeleting = false;
  String? error;

  Future<void> fetchEntries() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final result = await repository.getEntries();

      _entries
        ..clear()
        ..addAll(result);
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

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

  Future<bool> updateEntry(MusicDiaryEntry entry) async {
    isSaving = true;
    error = null;
    notifyListeners();

    try {
      final updatedEntry = await repository.updateEntry(entry);

      final index = _entries.indexWhere(
        (item) => item.id == updatedEntry.id,
      );

      if (index != -1) {
        _entries[index] = updatedEntry;
      } else {
        _entries.add(updatedEntry);
      }

      _entries.sort(
        (a, b) => b.listenedAt.compareTo(a.listenedAt),
      );

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

  Future<bool> deleteEntry(String id) async {
    isDeleting = true;
    error = null;
    notifyListeners();

    try {
      await repository.deleteEntry(id);

      _entries.removeWhere(
        (entry) => entry.id == id,
      );

      isDeleting = false;
      notifyListeners();

      return true;
    } catch (e) {
      error = e.toString();
      isDeleting = false;
      notifyListeners();

      return false;
    }
  }
}
