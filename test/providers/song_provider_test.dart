import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:melody_log/providers/song_provider.dart';
import 'package:melody_log/repositories/song_repository.dart';
import 'package:melody_log/services/song_service.dart';

void main() {
  group('SongProvider', () {
    test('should have initial state correctly', () {
      final client = MockClient((request) async {
        return http.Response('{}', 200);
      });

      final provider = SongProvider(
        SongRepository(
          SongService(client: client),
        ),
      );

      expect(provider.songs, isEmpty);
      expect(provider.query, '');
      expect(provider.isLoading, false);
      expect(provider.hasSearched, false);
      expect(provider.error, isNull);

      provider.dispose();
    });

    test('should load songs successfully', () async {
      final client = MockClient((request) async {
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

      final provider = SongProvider(
        SongRepository(
          SongService(client: client),
        ),
      );

      await provider.searchSongs('Taylor Swift');

      expect(provider.query, 'Taylor Swift');
      expect(provider.songs.length, 1);
      expect(provider.songs.first.trackName, 'Cruel Summer');
      expect(provider.isLoading, false);
      expect(provider.hasSearched, true);
      expect(provider.error, isNull);

      provider.dispose();
    });

    test('should show loading while waiting for API response', () async {
      final completer = Completer<http.Response>();

      final client = MockClient((request) {
        return completer.future;
      });

      final provider = SongProvider(
        SongRepository(
          SongService(client: client),
        ),
      );

      final searchFuture = provider.searchSongs('Coldplay');

      expect(provider.isLoading, true);
      expect(provider.query, 'Coldplay');

      completer.complete(
        http.Response(
          jsonEncode({
            'resultCount': 0,
            'results': [],
          }),
          200,
        ),
      );

      await searchFuture;

      expect(provider.isLoading, false);

      provider.dispose();
    });

    test('should handle empty search results', () async {
      final client = MockClient((request) async {
        return http.Response(
          jsonEncode({
            'resultCount': 0,
            'results': [],
          }),
          200,
        );
      });

      final provider = SongProvider(
        SongRepository(
          SongService(client: client),
        ),
      );

      await provider.searchSongs('Unknown Song');

      expect(provider.songs, isEmpty);
      expect(provider.hasSearched, true);
      expect(provider.error, isNull);
      expect(provider.isLoading, false);

      provider.dispose();
    });

    test('should handle API errors', () async {
      final client = MockClient((request) async {
        return http.Response('Server Error', 500);
      });

      final provider = SongProvider(
        SongRepository(
          SongService(client: client),
        ),
      );

      await provider.searchSongs('Taylor Swift');

      expect(provider.songs, isEmpty);
      expect(provider.error, isNotNull);
      expect(provider.isLoading, false);

      provider.dispose();
    });

    test('should clear search state', () async {
      final client = MockClient((request) async {
        return http.Response(
          jsonEncode({
            'resultCount': 1,
            'results': [
              {
                'trackId': 12345,
                'trackName': 'Cruel Summer',
                'artistName': 'Taylor Swift',
              }
            ],
          }),
          200,
        );
      });

      final provider = SongProvider(
        SongRepository(
          SongService(client: client),
        ),
      );

      await provider.searchSongs('Taylor Swift');
      provider.clearSearch();

      expect(provider.songs, isEmpty);
      expect(provider.query, '');
      expect(provider.isLoading, false);
      expect(provider.hasSearched, false);
      expect(provider.error, isNull);

      provider.dispose();
    });

    test('should retry the previous search', () async {
      var requestCount = 0;

      final client = MockClient((request) async {
        requestCount++;

        return http.Response(
          jsonEncode({
            'resultCount': 0,
            'results': [],
          }),
          200,
        );
      });

      final provider = SongProvider(
        SongRepository(
          SongService(client: client),
        ),
      );

      await provider.searchSongs('Coldplay');
      await provider.retrySearch();

      expect(requestCount, 2);
      expect(provider.query, 'Coldplay');
      expect(provider.hasSearched, true);

      provider.dispose();
    });
  });
}