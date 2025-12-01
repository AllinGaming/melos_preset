class Task {
  const Task({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  final int id;
  final String title;
  final bool isDone;

  Task toggle() => Task(id: id, title: title, isDone: !isDone);
}
