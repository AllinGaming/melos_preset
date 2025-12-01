import 'package:bloc/bloc.dart';
import 'package:core/core.dart';

class TasksCubit extends Cubit<List<Task>> {
  TasksCubit(this._repository) : super(const []) {
    load();
  }

  final TasksRepository _repository;

  void load() => emit(_repository.loadTasks());

  void toggle(int id) => emit(_repository.toggle(id));
}
