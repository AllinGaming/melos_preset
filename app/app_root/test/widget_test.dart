// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:app_root/src/app.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:networking/networking.dart';

void main() {
  setUp(() {
    resetDependencies();
    registerDependencies(
      exampleFetcher: const _StubFetcher(),
      tasksRepository: _StubTasksRepo(),
    );
  });

  tearDown(() {
    resetDependencies();
  });

  testWidgets('Melos Showcase UI loads its scaffold', (tester) async {
    await tester.pumpWidget(const MelosShowcaseApp());
    await tester.pumpAndSettle();

    expect(find.text('Melos Showcase'), findsOneWidget);
    expect(find.textContaining('Buildboard'), findsOneWidget);
  });
}

class _StubFetcher implements ExampleFetcher {
  const _StubFetcher();

  @override
  Future<ExampleResponse> fetchExample() async {
    return const ExampleResponse(
      userId: 1,
      id: 1,
      title: 'stubbed title',
      completed: false,
    );
  }
}

class _StubTasksRepo implements TasksRepository {
  @override
  List<Task> loadTasks() => const [
        Task(id: 1, title: 'one'),
        Task(id: 2, title: 'two', isDone: true),
      ];

  @override
  List<Task> toggle(int id) => loadTasks();
}
