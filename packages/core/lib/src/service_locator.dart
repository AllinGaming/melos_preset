import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:networking/networking.dart';

import 'tasks_repository.dart';

final sl = GetIt.instance;

ExampleFetcher _defaultFetcher() {
  if (kIsWeb) {
    // Avoid flaky browser adapter failures in dev/test by stubbing on web.
    return const _StubExampleFetcher();
  }
  return NetworkingRepository.create();
}

void registerDependencies({ExampleFetcher? exampleFetcher, TasksRepository? tasksRepository}) {
  if (!sl.isRegistered<ExampleFetcher>()) {
    sl.registerLazySingleton<ExampleFetcher>(
      () => exampleFetcher ?? _defaultFetcher(),
    );
  } else if (exampleFetcher != null) {
    sl.unregister<ExampleFetcher>();
    sl.registerLazySingleton<ExampleFetcher>(() => exampleFetcher);
  }

  if (!sl.isRegistered<TasksRepository>()) {
    sl.registerLazySingleton<TasksRepository>(
      () => tasksRepository ?? InMemoryTasksRepository(),
    );
  } else if (tasksRepository != null) {
    sl.unregister<TasksRepository>();
    sl.registerLazySingleton<TasksRepository>(() => tasksRepository);
  }
}

void resetDependencies() {
  sl.reset();
}

class _StubExampleFetcher implements ExampleFetcher {
  const _StubExampleFetcher();

  @override
  Future<ExampleResponse> fetchExample() async {
    return const ExampleResponse(
      userId: 0,
      id: 0,
      title: 'offline stub',
      completed: false,
    );
  }
}
