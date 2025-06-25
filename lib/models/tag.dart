import 'package:isar/isar.dart';

part 'tag.g.dart';

@collection
class Tag {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String name;

  @Index()
  late String? parentTag;

  @Index()
  late DateTime createdAt;

  @Index()
  late DateTime updatedAt;

  @Index()
  late int usageCount;

  late String color;

  late String description;

  Tag({
    required this.name,
    this.parentTag,
    required this.color,
    required this.description,
  }) {
    final now = DateTime.now();
    this.createdAt = now;
    this.updatedAt = now;
    this.usageCount = 0;
  }

  void incrementUsage() {
    usageCount++;
    updatedAt = DateTime.now();
  }

  void decrementUsage() {
    if (usageCount > 0) {
      usageCount--;
      updatedAt = DateTime.now();
    }
  }

  void updateDescription(String newDescription) {
    description = newDescription;
    updatedAt = DateTime.now();
  }

  void updateColor(String newColor) {
    color = newColor;
    updatedAt = DateTime.now();
  }

  bool get isChildTag => parentTag != null;

  String get fullName {
    if (parentTag != null) {
      return '$parentTag#$name';
    }
    return name;
  }
} 