import 'package:app_root/src/cubits/network_cubit.dart';
import 'package:app_root/src/cubits/tasks_cubit.dart';
import 'package:app_root/src/cubits/theme_cubit.dart';
import 'package:app_root/src/views/home_page.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:networking/networking.dart';

class _StubFetcher implements ExampleFetcher {
  const _StubFetcher({this.shouldFail = false});
  final bool shouldFail;

  @override
  Future<ExampleResponse> fetchExample() async {
    if (shouldFail) throw Exception('network down');
    return const ExampleResponse(
      userId: 10,
      id: 99,
      title: 'retrofit payload',
      completed: true,
    );
  }
}

class _StubTasksRepo implements TasksRepository {
  @override
  List<Task> loadTasks() => const [
        Task(id: 1, title: 'Craft a vibrant theme story'),
        Task(id: 2, title: 'Ship Retrofit diagnostics', isDone: true),
      ];

  @override
  List<Task> toggle(int id) => loadTasks();
}

class _StubFetcherCompletedFalse implements ExampleFetcher {
  const _StubFetcherCompletedFalse();

  @override
  Future<ExampleResponse> fetchExample() async => const ExampleResponse(
        userId: 3,
        id: 12,
        title: 'open item',
        completed: false,
      );
}

void main() {
  testWidgets('Home page shows hero, tasks, and network payload', (tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => TasksCubit(_StubTasksRepo())),
          BlocProvider(create: (_) => NetworkCubit(const _StubFetcher())..loadExample()),
          BlocProvider(create: (_) => ThemeCubit()),
        ],
        child: const MaterialApp(home: HomePage()),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.textContaining('Build faster with Melos'), findsOneWidget);
    expect(find.text('Buildboard'), findsOneWidget);
    expect(find.text('Ship Retrofit diagnostics'), findsOneWidget);
    expect(find.text('User 10'), findsOneWidget);
    expect(find.text('ID 99'), findsOneWidget);
    expect(find.text('retrofit payload'), findsOneWidget);
  });

  testWidgets('Network error renders retry affordance', (tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => TasksCubit(_StubTasksRepo())),
          BlocProvider(create: (_) => NetworkCubit(const _StubFetcher(shouldFail: true))..loadExample()),
          BlocProvider(create: (_) => ThemeCubit()),
        ],
        child: const MaterialApp(home: HomePage()),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.textContaining('Failed to load demo payload'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
  });

  testWidgets('Network status shows open item when not completed', (tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => TasksCubit(_StubTasksRepo())),
          BlocProvider(
            create: (_) => NetworkCubit(const _StubFetcherCompletedFalse())..loadExample(),
          ),
          BlocProvider(create: (_) => ThemeCubit()),
        ],
        child: const MaterialApp(home: HomePage()),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.textContaining('Open'), findsOneWidget);
  });

  testWidgets('Network status handles empty initial state', (tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => TasksCubit(_StubTasksRepo())),
          BlocProvider(create: (_) => NetworkCubit(const _StubFetcher())),
          BlocProvider(create: (_) => ThemeCubit()),
        ],
        child: const MaterialApp(home: HomePage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('No payload yet'), findsOneWidget);
  });
}
