import 'package:flutter_test/flutter_test.dart';
import 'package:melody_log/models/song.dart';

void main() {
  group('Song Model', () {
    test('should convert iTunes JSON into Song object', () {
      final json = {
        'trackId': 12345,
        'trackName': 'Cruel Summer',
        'artistName': 'Taylor Swift',
        'collectionName': 'Lover',
        'artworkUrl100': 'https://example.com/artwork.jpg',
        'primaryGenreName': 'Pop',
        'trackTimeMillis': 178000,
        'releaseDate': '2019-08-23T07:00:00Z',
      };

      final song = Song.fromJson(json);

      expect(song.trackId, 12345);
      expect(song.trackName, 'Cruel Summer');
      expect(song.artistName, 'Taylor Swift');
      expect(song.albumName, 'Lover');
      expect(song.artworkUrl, 'https://example.com/artwork.jpg');
      expect(song.genre, 'Pop');
      expect(song.trackTimeMillis, 178000);
      expect(song.releaseDate, isNotNull);
    });

    test('should format song duration correctly', () {
      const song = Song(
        trackId: 1,
        trackName: 'Test Song',
        artistName: 'Test Artist',
        trackTimeMillis: 178000,
      );

      expect(song.formattedDuration, '2:58');
    });

    test('should return unknown duration when duration is missing', () {
      const song = Song(
        trackId: 1,
        trackName: 'Test Song',
        artistName: 'Test Artist',
      );

      expect(song.formattedDuration, 'Unknown duration');
    });
  });
}