import 'package:flutter/foundation.dart';

import '../models/song.dart';
import '../repositories/song_repository.dart';

class SongProvider extends ChangeNotifier {
  final SongRepository repository;

  SongProvider(this.repository);

  List<Song> songs = [];

  bool isLoading = false;
  String? error;

  int _requestId = 0;

  Future<void> searchSongs(String query) async {
    final keyword = query.trim();

    if (keyword.isEmpty) {
      _requestId++;
      songs = [];
      error = null;
      isLoading = false;
      notifyListeners();
      return;
    }

    final currentRequestId = ++_requestId;

    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final result = await repository.searchSongs(keyword);

      // Mengabaikan hasil pencarian lama jika ada pencarian baru.
      if (currentRequestId != _requestId) return;

      songs = result;
    } catch (e) {
      if (currentRequestId != _requestId) return;

      error = e.toString();
      songs = [];
    } finally {
      if (currentRequestId == _requestId) {
        isLoading = false;
        notifyListeners();
      }
    }
  }
}