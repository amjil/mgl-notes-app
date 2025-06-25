import 'package:isar/isar.dart';

part 'note.g.dart';

@collection
class Note {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime createdAt;

  @Index()
  late DateTime updatedAt;

  late String title;

  late String content;

  @Index()
  late List<String> tags;

  @Index()
  late bool isDeleted;

  @Index()
  late DateTime? deletedAt;

  @Index()
  late DateTime? scheduledDate;

  late int wordCount;

  late int blockCount;

  Note({
    required this.title,
    required this.content,
    required this.tags,
    this.scheduledDate,
  }) {
    final now = DateTime.now();
    this.createdAt = now;
    this.updatedAt = now;
    this.isDeleted = false;
    this.deletedAt = null;
    this.scheduledDate = scheduledDate;
    this.wordCount = _calculateWordCount(content);
    this.blockCount = _calculateBlockCount(content);
  }

  int _calculateWordCount(String content) {
    // 简单的词数计算，按空格分割
    return content.trim().split(RegExp(r'\s+')).length;
  }

  int _calculateBlockCount(String content) {
    // 计算块的数量，按双换行符分割
    return content.split('\n\n').length;
  }

  void updateContent(String newContent) {
    this.content = newContent;
    this.updatedAt = DateTime.now();
    this.wordCount = _calculateWordCount(newContent);
    this.blockCount = _calculateBlockCount(newContent);
  }

  void addTag(String tag) {
    if (!tags.contains(tag)) {
      tags.add(tag);
      updatedAt = DateTime.now();
    }
  }

  void removeTag(String tag) {
    if (tags.remove(tag)) {
      updatedAt = DateTime.now();
    }
  }

  void softDelete() {
    isDeleted = true;
    deletedAt = DateTime.now();
  }

  void restore() {
    isDeleted = false;
    deletedAt = null;
  }
} 