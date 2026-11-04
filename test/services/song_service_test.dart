import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:melody_log/services/song_service.dart';
import 'package:melody_log/repositories/song_repository.dart';

void main() {
  group('SongService and SongRepository', () {
    test('should request iTunes API and return song results', () async {
      final mockClient = MockClient((request) async {
        expect(request.url.host, 'itunes.apple.com');
        expect(request.url.path, '/search');
        expect(request.url.queryParameters['term'], 'Taylor Swift');
        expect(request.url.queryParameters['entity'], 'song');
        expect(request.url.queryParameters['country'], 'id');

        return http.Response(
          jsonEncode({
            'resultCount': 1,
            'results': [
              {
                'trackId': 12345,
                'trackName': 'Cruel Summer',
                'artistName': 'Taylor Swift',
                'collectionName': 'Lover',
                'artworkUrl100': 'https://example.com/artwork.jpg',
                'primaryGenreName': 'Pop',
                'trackTimeMillis': 178000,
              }
            ],
          }),
          200,
        );
      });

      final service = SongService(client: mockClient);
      final repository = SongRepository(service);

      final songs = await repository.searchSongs('Taylor Swift');

      expect(songs.length, 1);
      expect(songs.first.trackName, 'Cruel Summer');
      expect(songs.first.artistName, 'Taylor Swift');
      expect(songs.first.albumName, 'Lover');
    });

    test('should throw exception when API returns an error status',
        () async {
      final mockClient = MockClient((request) async {
        return http.Response('Server Error', 500);
      });

      final service = SongService(client: mockClient);

      expect(
        () => service.searchSongs('Taylor Swift'),
        throwsException,
      );
    });
  });
}