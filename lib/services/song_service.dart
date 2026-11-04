import 'dart:convert';

import 'package:http/http.dart' as http;

class SongService {
  final http.Client client;

  SongService({http.Client? client})
      : client = client ?? http.Client();

  Future<Map<String, dynamic>> searchSongs(String query) async {
    final uri = Uri.https(
      'itunes.apple.com',
      '/search',
      {
        'term': query,
        'entity': 'song',
        'limit': '25',
        'country': 'id',
      },
    );

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data is Map<String, dynamic>) {
        return data;
      }

      throw Exception('Invalid response format from iTunes API.');
    }

    throw Exception(
      'Failed to load songs. Status code: ${response.statusCode}',
    );
  }
}