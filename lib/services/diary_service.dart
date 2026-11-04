
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

  Future<List<Map<String, dynamic>>> getEntries() async {
    final response = await _client
        .from('music_diary_entries')
        .select()
        .order('listened_at', ascending: false);

    return response
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  Future<Map<String, dynamic>> updateEntry(
    String id,
    Map<String, dynamic> data,
  ) async {
    final response = await _client
        .from('music_diary_entries')
        .update(data)
        .eq('id', id)
        .select()
        .single();

    return response;
  }
}
