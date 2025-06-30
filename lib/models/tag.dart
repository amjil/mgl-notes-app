import 'package:isar/isar.dart';

part 'tag.g.dart';

@collection
class Tag {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String name;

  @Index()
  late int usageCount;

  List<Id> noteIds = [];

  List<Id> blockIds = [];

  Tag({
    required this.name,
  }) {
    this.usageCount = 0;
  }

  void incrementUsage() {
    usageCount++;
  }

  void decrementUsage() {
    if (usageCount > 0) {
      usageCount--;
    }
  }
} 