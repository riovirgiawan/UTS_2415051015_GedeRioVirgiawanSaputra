import 'package:flutter_test/flutter_test.dart';
import 'package:melody_log/models/music_diary_entry.dart';

void main() {
  group('MusicDiaryEntry Model', () {
    test('should convert Supabase JSON into MusicDiaryEntry object', () {
      final json = {
        'id': 'entry-001',
        'track_id': '12345',
        'track_name': 'Cruel Summer',
        'artist_name': 'Taylor Swift',
        'album_name': 'Lover',
        'artwork_url': 'https://example.com/artwork.jpg',
        'listened_at': '2026-11-04T10:00:00.000Z',
        'mood': 'Happy',
        'rating': 5,
        'note': 'This song makes my day better.',
      };

      final entry = MusicDiaryEntry.fromJson(json);

      expect(entry.id, 'entry-001');
      expect(entry.trackId, 12345);
      expect(entry.trackName, 'Cruel Summer');
      expect(entry.artistName, 'Taylor Swift');
      expect(entry.albumName, 'Lover');
      expect(entry.mood, 'Happy');
      expect(entry.rating, 5);
      expect(entry.note, 'This song makes my day better.');
    });

    test('should convert MusicDiaryEntry object into Supabase JSON', () {
      final entry = MusicDiaryEntry(
        id: 'entry-001',
        trackId: 12345,
        trackName: 'Cruel Summer',
        artistName: 'Taylor Swift',
        albumName: 'Lover',
        artworkUrl: 'https://example.com/artwork.jpg',
        listenedAt: DateTime.parse('2026-11-04T10:00:00.000Z'),
        mood: 'Happy',
        rating: 5,
        note: 'This song makes my day better.',
      );

      final json = entry.toJson();

      expect(json['track_id'], '12345');
      expect(json['track_name'], 'Cruel Summer');
      expect(json['artist_name'], 'Taylor Swift');
      expect(json['mood'], 'Happy');
      expect(json['rating'], 5);
      expect(json['note'], 'This song makes my day better.');
      expect(json.containsKey('id'), false);
    });
  });
}