import 'package:app_root/src/app.dart';
import 'package:app_root/src/views/details_page.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:networking/networking.dart';
import 'package:go_router/go_router.dart';

class _CountingFetcher implements ExampleFetcher {
  _CountingFetcher(this.response);
  final ExampleResponse response;
  int calls = 0;

  @override
  Future<ExampleResponse> fetchExample() async {
    calls++;
    return response;
  }
}

class _MutableTasksRepo implements TasksRepository {
  _MutableTasksRepo(this.tasks);
  List<Task> tasks;

  @override
  List<Task> loadTasks() => tasks;

  @override
  List<Task> toggle(int id) {
    tasks = tasks
        .map((t) => t.id == id ? t.toggle() : t)
        .toList(growable: false);
    return loadTasks();
  }
}

void main() {
  late _CountingFetcher fetcher;
  late _MutableTasksRepo repo;

  setUp(() {
    resetDependencies();
    fetcher = _CountingFetcher(
      const ExampleResponse(
        userId: 1,
        id: 2,
        title: 'from test',
        completed: false,
      ),
    );
    repo = _MutableTasksRepo(const [
      Task(id: 1, title: 'first'),
      Task(id: 2, title: 'second'),
    ]);
    registerDependencies(exampleFetcher: fetcher, tasksRepository: repo);
  });

  tearDown(() {
    resetDependencies();
  });

  testWidgets('Tasks toggle updates UI', (tester) async {
    await tester.pumpWidget(const MelosShowcaseApp());
    await tester.pumpAndSettle();

    final firstTaskCheckbox = find.byType(CheckboxListTile).first;
    expect(tester.widget<CheckboxListTile>(firstTaskCheckbox).value, isFalse);

    await tester.tap(firstTaskCheckbox);
    await tester.pumpAndSettle();

    expect(tester.widget<CheckboxListTile>(firstTaskCheckbox).value, isTrue);
  });

  testWidgets('Refresh button triggers fetcher', (tester) async {
    await tester.pumpWidget(const MelosShowcaseApp());
    await tester.pumpAndSettle();

    expect(fetcher.calls, greaterThanOrEqualTo(1));
    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pumpAndSettle();
    expect(fetcher.calls, greaterThanOrEqualTo(2));
  });

  testWidgets('Navigates to details and back safely', (tester) async {
    final binding = TestWidgetsFlutterBinding.ensureInitialized() as TestWidgetsFlutterBinding;
    binding.window.physicalSizeTestValue = const Size(1200, 2000);
    binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(() {
      binding.window.clearPhysicalSizeTestValue();
      binding.window.clearDevicePixelRatioTestValue();
    });

    await tester.pumpWidget(const MelosShowcaseApp());
    await tester.pumpAndSettle();

    final goButton = find.byIcon(Icons.arrow_forward);
    expect(goButton, findsOneWidget);
    await tester.tap(goButton);
    await tester.pumpAndSettle();

    expect(find.byType(DetailsPage), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.text('Melos Showcase'), findsOneWidget);
  });
}
