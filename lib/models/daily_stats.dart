import 'package:isar/isar.dart';

part 'daily_stats.g.dart';

@collection
class DailyStats {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late DateTime date;

  late int noteCount;

  late int wordCount;

  late int blockCount;

  late List<String> tags;

  DailyStats({
    required this.date,
    this.noteCount = 0,
    this.wordCount = 0,
    this.blockCount = 0,
    required this.tags,
  });

  void incrementNoteCount() {
    noteCount++;
  }

  void decrementNoteCount() {
    if (noteCount > 0) {
      noteCount--;
    }
  }

  void addWordCount(int words) {
    wordCount += words;
  }

  void subtractWordCount(int words) {
    if (wordCount >= words) {
      wordCount -= words;
    }
  }

  void addBlockCount(int blocks) {
    blockCount += blocks;
  }

  void subtractBlockCount(int blocks) {
    if (blockCount >= blocks) {
      blockCount -= blocks;
    }
  }

  void addTag(String tag) {
    if (!tags.contains(tag)) {
      tags.add(tag);
    }
  }

  void removeTag(String tag) {
    tags.remove(tag);
  }

  bool get hasActivity => noteCount > 0 || wordCount > 0 || blockCount > 0;
} 