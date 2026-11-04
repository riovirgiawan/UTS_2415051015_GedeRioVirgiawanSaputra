import '../models/song.dart';
import '../services/song_service.dart';

class SongRepository {
  final SongService service;

  SongRepository(this.service);

  Future<List<Song>> searchSongs(String query) async {
    final response = await service.searchSongs(query);

    final results = response['results'];

    if (results is! List) {
      throw Exception('Song results are not available.');
    }

    return results
        .whereType<Map<String, dynamic>>()
        .map((json) => Song.fromJson(json))
        .toList();
  }
}