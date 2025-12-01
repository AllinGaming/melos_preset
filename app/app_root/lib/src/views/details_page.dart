import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubits/network_cubit.dart';
import '../widgets/section_card.dart';
import 'home_page.dart';
import '../cubits/tasks_cubit.dart';
import 'package:core/core.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            final router = GoRouter.of(context);
            if (router.canPop()) {
              router.pop();
            } else {
              router.go(HomePage.routeName);
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SectionCard(
              title: 'Task snapshot',
              child: BlocBuilder<TasksCubit, List<Task>>(
                builder: (context, tasks) {
                  final completed = tasks.where((t) => t.isDone).length;
                  return Text('Completed $completed of ${tasks.length} tasks');
                },
              ),
            ),
            const SizedBox(height: 16),
            SectionCard(
              title: 'Network snapshot',
              child: BlocBuilder<NetworkCubit, NetworkState>(
                builder: (context, state) {
                  final payload = state.data;
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (payload == null) {
                    return const Text('No payload, return to home to trigger it.');
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('id: ${payload.id}'),
                      Text('title: ${payload.title}'),
                      Text('completed: ${payload.completed}'),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
