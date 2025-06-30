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

  // Link fields - format: note#block-id
  late List<String> links;

  // Backlink fields - referenced records
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

  // Add link
  void addLink(String link) {
    if (!links.contains(link)) {
      links.add(link);
    }
  }

  // Remove link
  void removeLink(String link) {
    links.remove(link);
  }

  // Add backlink
  void addBacklink(String backlink) {
    if (!backlinks.contains(backlink)) {
      backlinks.add(backlink);
    }
  }

  // Remove backlink
  void removeBacklink(String backlink) {
    backlinks.remove(backlink);
  }

  // Get all links
  List<String> getLinks() {
    return List.from(links);
  }

  // Get all backlinks
  List<String> getBacklinks() {
    return List.from(backlinks);
  }
} 