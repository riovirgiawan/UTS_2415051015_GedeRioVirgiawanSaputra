class MusicDiaryEntry {
  final String id;
  final int trackId;
  final String trackName;
  final String artistName;
  final String? albumName;
  final String? artworkUrl;
  final DateTime listenedAt;
  final String mood;
  final int rating;
  final String note;

  const MusicDiaryEntry({
    required this.id,
    required this.trackId,
    required this.trackName,
    required this.artistName,
    this.albumName,
    this.artworkUrl,
    required this.listenedAt,
    required this.mood,
    required this.rating,
    required this.note,
  });

  factory MusicDiaryEntry.fromJson(Map<String, dynamic> json) {
    return MusicDiaryEntry(
      id: json['id']?.toString() ?? '',
      trackId: _parseInt(json['track_id']) ?? 0,
      trackName: json['track_name']?.toString() ?? '',
      artistName: json['artist_name']?.toString() ?? '',
      albumName: json['album_name']?.toString(),
      artworkUrl: json['artwork_url']?.toString(),
      listenedAt: DateTime.parse(json['listened_at'].toString()),
      mood: json['mood']?.toString() ?? '',
      rating: _parseInt(json['rating']) ?? 0,
      note: json['note']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'track_id': trackId.toString(),
      'track_name': trackName,
      'artist_name': artistName,
      'album_name': albumName,
      'artwork_url': artworkUrl,
      'listened_at': listenedAt.toIso8601String(),
      'mood': mood,
      'rating': rating,
      'note': note,
    };
  }

  static int? _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
}