// Link data model
class Link {
  final String id;
  final String fromBlockId;
  final String toNoteId;
  final String? toBlockId;
  final DateTime createdAt;

  Link({
    required this.id,
    required this.fromBlockId,
    required this.toNoteId,
    this.toBlockId,
    required this.createdAt,
  });

  // Create Link object from JSON
  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      id: json['id'] as String,
      fromBlockId: json['from_block_id'] as String,
      toNoteId: json['to_note_id'] as String,
      toBlockId: json['to_block_id'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'from_block_id': fromBlockId,
      'to_note_id': toNoteId,
      'to_block_id': toBlockId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  // Create copy
  Link copyWith({
    String? id,
    String? fromBlockId,
    String? toNoteId,
    String? toBlockId,
    DateTime? createdAt,
  }) {
    return Link(
      id: id ?? this.id,
      fromBlockId: fromBlockId ?? this.fromBlockId,
      toNoteId: toNoteId ?? this.toNoteId,
      toBlockId: toBlockId ?? this.toBlockId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Link &&
        other.id == id &&
        other.fromBlockId == fromBlockId &&
        other.toNoteId == toNoteId &&
        other.toBlockId == toBlockId &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fromBlockId.hashCode ^
        toNoteId.hashCode ^
        toBlockId.hashCode ^
        createdAt.hashCode;
  }

  @override
  String toString() {
    return 'Link(id: $id, fromBlockId: $fromBlockId, toNoteId: $toNoteId, toBlockId: $toBlockId, createdAt: $createdAt)';
  }
} 