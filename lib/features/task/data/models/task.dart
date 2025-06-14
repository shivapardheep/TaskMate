class Task {
  final String id;
  String title;
  String description;
  bool isCompleted;
  final String userId;
  final String createdAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.createdAt,
    required this.userId,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    isCompleted: json['isCompleted'] ?? false,
    userId: json['userId'],
    createdAt: json['createdAt'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'isCompleted': isCompleted,
    'userId': userId,
    'createdAt': createdAt,
  };
}
