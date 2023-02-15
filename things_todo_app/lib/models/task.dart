class Task {
  final String name;
  final String description;
  bool isCompleted;

  Task({
    required this.name,
    required this.description,
    this.isCompleted = false,
  });
}
