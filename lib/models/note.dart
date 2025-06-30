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

  late List<Id> blockIds;

  Note({
    required this.title,
    required this.blockIds,
    required this.tags,
    this.scheduledDate,
  }) {
    final now = DateTime.now();
    this.createdAt = now;
    this.updatedAt = now;
    this.isDeleted = false;
    this.deletedAt = null;
    this.scheduledDate = scheduledDate;
    this.wordCount = 0; // Need to calculate from blocks
    this.blockCount = blockIds.length;
  }

  void updateBlockIds(List<Id> newBlockIds) {
    this.blockIds = newBlockIds;
    this.updatedAt = DateTime.now();
    this.blockCount = newBlockIds.length;
    // Need to recalculate word count here, but need access to block content
    // this.wordCount = _calculateWordCountFromBlocks(newBlockIds);
  }

  void addBlockId(Id blockId) {
    if (!blockIds.contains(blockId)) {
      blockIds.add(blockId);
      updatedAt = DateTime.now();
      blockCount = blockIds.length;
    }
  }

  void removeBlockId(Id blockId) {
    if (blockIds.remove(blockId)) {
      updatedAt = DateTime.now();
      blockCount = blockIds.length;
    }
  }

  void insertBlockId(int index, Id blockId) {
    if (!blockIds.contains(blockId)) {
      blockIds.insert(index, blockId);
      updatedAt = DateTime.now();
      blockCount = blockIds.length;
    }
  }

  void moveBlockId(int fromIndex, int toIndex) {
    if (fromIndex >= 0 && fromIndex < blockIds.length && 
        toIndex >= 0 && toIndex < blockIds.length) {
      final blockId = blockIds.removeAt(fromIndex);
      blockIds.insert(toIndex, blockId);
      updatedAt = DateTime.now();
    }
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

  // Update block count
  void updateBlockCount(int newCount) {
    this.blockCount = newCount;
    this.updatedAt = DateTime.now();
  }

  // Get next block order
  int getNextBlockOrder() {
    return blockCount;
  }

  // Update word count (need to calculate from blocks)
  void updateWordCount(int newWordCount) {
    this.wordCount = newWordCount;
    this.updatedAt = DateTime.now();
  }
} 