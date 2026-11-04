class Song {
  final int trackId;
  final String trackName;
  final String artistName;
  final String? albumName;
  final String? artworkUrl;
  final String? genre;
  final int? trackTimeMillis;
  final DateTime? releaseDate;

  const Song({
    required this.trackId,
    required this.trackName,
    required this.artistName,
    this.albumName,
    this.artworkUrl,
    this.genre,
    this.trackTimeMillis,
    this.releaseDate,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      trackId: _parseInt(json['trackId']) ?? 0,
      trackName: json['trackName']?.toString() ?? '',
      artistName: json['artistName']?.toString() ?? '',
      albumName: json['collectionName']?.toString(),
      artworkUrl: json['artworkUrl100']?.toString(),
      genre: json['primaryGenreName']?.toString(),
      trackTimeMillis: _parseInt(json['trackTimeMillis']),
      releaseDate: _parseDate(json['releaseDate']),
    );
  }

  static int? _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  String get formattedDuration {
    if (trackTimeMillis == null || trackTimeMillis! <= 0) {
      return 'Unknown duration';
    }

    final totalSeconds = trackTimeMillis! ~/ 1000;
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}