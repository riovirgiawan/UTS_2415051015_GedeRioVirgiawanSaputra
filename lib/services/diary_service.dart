
import 'package:supabase_flutter/supabase_flutter.dart';

class DiaryService {
  final SupabaseClient _client;

  DiaryService(this._client);

  Future<Map<String, dynamic>> createEntry(
    Map<String, dynamic> data,
  ) async {
    final response = await _client
        .from('music_diary_entries')
        .insert(data)
        .select()
        .single();

    return response;
  }
}
