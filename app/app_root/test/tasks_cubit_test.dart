import 'package:app_root/src/cubits/network_cubit.dart';
import 'package:app_root/src/cubits/tasks_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:networking/networking.dart';

class _FakeFetcher implements ExampleFetcher {
  _FakeFetcher(this.response);

  final ExampleResponse response;

  @override
  Future<ExampleResponse> fetchExample() async => response;
}

class _FakeTasksRepo implements TasksRepository {
  _FakeTasksRepo(this.tasks);
  List<Task> tasks;

  @override
  List<Task> loadTasks() => tasks;

  @override
  List<Task> toggle(int id) {
    tasks = tasks
        .map((t) => t.id == id ? t.toggle() : t)
        .toList(growable: false);
    return tasks;
  }
}

void main() {
  test('Tasks cubit loads and toggles tasks', () {
    final repo = _FakeTasksRepo(const [
      Task(id: 1, title: 'one'),
      Task(id: 2, title: 'two'),
    ]);
    final cubit = TasksCubit(repo);

    expect(cubit.state.length, 2);
    cubit.toggle(1);
    expect(cubit.state.first.isDone, isTrue);
  });

  test('Network cubit emits loading then data', () async {
    final stub = _FakeFetcher(
      const ExampleResponse(
        userId: 42,
        id: 7,
        title: 'stubbed data',
        completed: true,
      ),
    );
    final cubit = NetworkCubit(stub);

    await cubit.loadExample();

    expect(cubit.state.isLoading, isFalse);
    expect(cubit.state.data, isNotNull);
    expect(cubit.state.data!.id, 7);
  });
}
