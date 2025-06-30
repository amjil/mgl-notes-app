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
  late List<String> tags;

  @Index()
  late bool isDeleted;

  // 链接字段 - 形式为 note#block-id
  late List<String> links;

  // 反向链接字段 - 被引用记录
  late List<String> backlinks;

  Block({
    required this.blockId,
    required this.noteId,
    required this.content,
    required this.tags,
  }) {
    this.isDeleted = false;
    this.links = [];
    this.backlinks = [];
  }

  void updateContent(String newContent) {
    this.content = newContent;
  }

  void addTag(String tag) {
    if (!tags.contains(tag)) {
      tags.add(tag);
    }
  }

  void removeTag(String tag) {
    tags.remove(tag);
  }

  void softDelete() {
    isDeleted = true;
  }

  void restore() {
    isDeleted = false;
  }

  // 添加链接
  void addLink(String link) {
    if (!links.contains(link)) {
      links.add(link);
    }
  }

  // 移除链接
  void removeLink(String link) {
    links.remove(link);
  }

  // 添加反向链接
  void addBacklink(String backlink) {
    if (!backlinks.contains(backlink)) {
      backlinks.add(backlink);
    }
  }

  // 移除反向链接
  void removeBacklink(String backlink) {
    backlinks.remove(backlink);
  }

  // 获取所有链接
  List<String> getLinks() {
    return List.from(links);
  }

  // 获取所有反向链接
  List<String> getBacklinks() {
    return List.from(backlinks);
  }
} 