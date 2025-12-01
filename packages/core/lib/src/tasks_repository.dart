import 'task.dart';

abstract class TasksRepository {
  List<Task> loadTasks();
  List<Task> toggle(int id);
}

class InMemoryTasksRepository implements TasksRepository {
  InMemoryTasksRepository({List<Task>? seed}) : _tasks = seed ?? _defaultTasks;

  List<Task> _tasks;

  @override
  List<Task> loadTasks() => List.unmodifiable(_tasks);

  @override
  List<Task> toggle(int id) {
    _tasks = _tasks
        .map((task) => task.id == id ? task.toggle() : task)
        .toList(growable: false);
    return loadTasks();
  }

  static const _defaultTasks = [
    Task(id: 1, title: 'Craft a vibrant theme story'),
    Task(id: 2, title: 'Harden DI with GetIt'),
    Task(id: 3, title: 'Ship Retrofit diagnostics'),
  ];
}
