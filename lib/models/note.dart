import 'package:drift/drift.dart';

// Note data model
class Note {
  final String id;
  final String title;
  final String blockIds;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;

  Note({
    required this.id,
    required this.title,
    required this.blockIds,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
  });

  // Create Note object from JSON
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] as String,
      title: json['title'] as String,
      blockIds: json['block_ids'] as String? ?? '[]',
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      syncStatus: json['sync_status'] as String? ?? 'pending',
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'block_ids': blockIds,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'sync_status': syncStatus,
    };
  }

  // Create copy
  Note copyWith({
    String? id,
    String? title,
    String? blockIds,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      blockIds: blockIds ?? this.blockIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Note &&
        other.id == id &&
        other.title == title &&
        other.blockIds == blockIds &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.syncStatus == syncStatus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        blockIds.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        syncStatus.hashCode;
  }

  @override
  String toString() {
    return 'Note(id: $id, title: $title, blockIds: $blockIds, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus)';
  }
} 