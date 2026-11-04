
import '../models/music_diary_entry.dart';
import '../services/diary_service.dart';

class DiaryRepository {
  final DiaryService service;

  DiaryRepository(this.service);

  Future<MusicDiaryEntry> createEntry(
    MusicDiaryEntry entry,
  ) async {
    final response = await service.createEntry(
      entry.toJson(),
    );

    return MusicDiaryEntry.fromJson(response);
  }
}
