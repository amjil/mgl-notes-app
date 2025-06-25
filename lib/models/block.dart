import 'package:isar/isar.dart';

part 'block.g.dart';

@collection
class Block {
  Id id = Isar.autoIncrement;

  @Index()
  late String blockId;

  @Index()
  late int noteId;

  late String content;

  @Index()
  late DateTime createdAt;

  @Index()
  late DateTime updatedAt;

  late int order;

  @Index()
  late List<String> tags;

  @Index()
  late bool isDeleted;

  Block({
    required this.blockId,
    required this.noteId,
    required this.content,
    required this.order,
    required this.tags,
  }) {
    final now = DateTime.now();
    this.createdAt = now;
    this.updatedAt = now;
    this.isDeleted = false;
  }

  void updateContent(String newContent) {
    this.content = newContent;
    this.updatedAt = DateTime.now();
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
  }

  void restore() {
    isDeleted = false;
  }
} 