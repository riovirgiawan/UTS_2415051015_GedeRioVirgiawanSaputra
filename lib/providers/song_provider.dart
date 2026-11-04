import 'package:flutter/foundation.dart';

import '../models/song.dart';
import '../repositories/song_repository.dart';

class SongProvider extends ChangeNotifier {
  final SongRepository repository;

  SongProvider(this.repository);

  // Data hasil pencarian lagu.
  List<Song> songs = [];

  // Keyword pencarian terakhir.
  String query = '';

  // Status pengambilan data.
  bool isLoading = false;
  bool hasSearched = false;
  String? error;

  // Penanda untuk mengabaikan respons pencarian yang sudah lama.
  int _requestId = 0;

  Future<void> searchSongs(String keyword) async {
    final searchQuery = keyword.trim();

    if (searchQuery.isEmpty) {
      clearSearch();
      return;
    }

    final currentRequestId = ++_requestId;

    query = searchQuery;
    isLoading = true;
    hasSearched = true;
    error = null;

    notifyListeners();

    try {
      final result = await repository.searchSongs(searchQuery);

      // Abaikan hasil jika sudah ada pencarian yang lebih baru.
      if (currentRequestId != _requestId) return;

      songs = result;
    } catch (e) {
      if (currentRequestId != _requestId) return;

      songs = [];
      error = e.toString();
    } finally {
      if (currentRequestId == _requestId) {
        isLoading = false;
        notifyListeners();
      }
    }
  }

  void clearSearch() {
    // Membatalkan pengaruh respons pencarian sebelumnya.
    _requestId++;

    query = '';
    songs = [];
    isLoading = false;
    hasSearched = false;
    error = null;

    notifyListeners();
  }

  Future<void> retrySearch() async {
    if (query.isNotEmpty) {
      await searchSongs(query);
    }
  }
}