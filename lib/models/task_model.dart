// TODO Implement this library.
class Task {
  int? id;
  String title;
  DateTime createdAt;
  DateTime? completedAt;
  bool isBookmarked;
  bool isImportant;

  Task({
    this.id,
    required this.title,
    required this.createdAt,
    this.completedAt,
    this.isBookmarked = false,
    this.isImportant = false,
  });

// Convert Task object to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'isBookmarked': isBookmarked ? 1 : 0,
      'isImportant': isImportant ? 1 : 0,
    };
  }

// Create Task object from Map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      createdAt: DateTime.parse(map['createdAt']),
      completedAt:
      map['completedAt'] != null ? DateTime.parse(map['completedAt']) : null,
      isBookmarked: map['isBookmarked'] == 1,
      isImportant: map['isImportant'] == 1,
    );
  }
}

