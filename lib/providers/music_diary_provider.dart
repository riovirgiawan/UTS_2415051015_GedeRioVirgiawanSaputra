
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

  // Mengambil seluruh diary dari Supabase.
  Future<void> fetchEntries() async {
    if (isLoading) return;

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
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Menambahkan diary baru.
  Future<bool> addEntry(MusicDiaryEntry entry) async {
    if (isSaving || isDeleting) return false;

    isSaving = true;
    error = null;
    notifyListeners();

    try {
      final savedEntry = await repository.createEntry(entry);

      _entries.insert(0, savedEntry);

      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  // Memperbarui diary.
  Future<bool> updateEntry(MusicDiaryEntry entry) async {
    if (isSaving || isDeleting) return false;

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

      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  // Menghapus diary.
  Future<bool> deleteEntry(String id) async {
    if (isSaving || isDeleting) return false;

    isDeleting = true;
    error = null;
    notifyListeners();

    try {
      await repository.deleteEntry(id);

      _entries.removeWhere(
        (entry) => entry.id == id,
      );

      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isDeleting = false;
      notifyListeners();
    }
  }
}
