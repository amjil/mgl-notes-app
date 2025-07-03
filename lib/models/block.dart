// Block data model
class Block {
  final String id;
  final String noteId;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;

  Block({
    required this.id,
    required this.noteId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
  });

  // Create Block object from JSON
  factory Block.fromJson(Map<String, dynamic> json) {
    return Block(
      id: json['id'] as String,
      noteId: json['note_id'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      syncStatus: json['sync_status'] as String? ?? 'pending',
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'note_id': noteId,
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'sync_status': syncStatus,
    };
  }

  // Create copy
  Block copyWith({
    String? id,
    String? noteId,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) {
    return Block(
      id: id ?? this.id,
      noteId: noteId ?? this.noteId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Block &&
        other.id == id &&
        other.noteId == noteId &&
        other.content == content &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.syncStatus == syncStatus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        noteId.hashCode ^
        content.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        syncStatus.hashCode;
  }

  @override
  String toString() {
    return 'Block(id: $id, noteId: $noteId, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus)';
  }
} 