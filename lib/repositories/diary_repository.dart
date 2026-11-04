
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

  Future<List<MusicDiaryEntry>> getEntries() async {
    final response = await service.getEntries();

    return response
        .map((item) => MusicDiaryEntry.fromJson(item))
        .toList();
  }

  Future<MusicDiaryEntry> updateEntry(
    MusicDiaryEntry entry,
  ) async {
    final response = await service.updateEntry(
      entry.id,
      entry.toJson(),
    );

    return MusicDiaryEntry.fromJson(response);
  }
}
