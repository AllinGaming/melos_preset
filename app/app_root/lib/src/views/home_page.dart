import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubits/network_cubit.dart';
import '../cubits/tasks_cubit.dart';
import '../cubits/theme_cubit.dart';
import '../widgets/section_card.dart';
import 'details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Melos Showcase'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<NetworkCubit>().loadExample(),
            tooltip: 'Refetch demo payload',
          ),
          IconButton(
            icon: const Icon(Icons.nightlight_round),
            onPressed: () => context.read<ThemeCubit>().toggle(),
            tooltip: 'Toggle theme',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.4),
              Theme.of(context).colorScheme.surface,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _HeroHeader(),
            const SizedBox(height: 16),
            const SectionCard(
              title: 'Buildboard',
              child: _TasksList(),
            ),
            const SizedBox(height: 16),
            const SectionCard(
              title: 'Networking & Retrofit',
              child: _NetworkStatus(),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
              ),
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Inspect details screen'),
              onPressed: () => context.go(DetailsPage.routeName),
            ),
          ],
        ),
      ),
    );
  }
}

class _TasksList extends StatelessWidget {
  const _TasksList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, List<Task>>(
      builder: (context, tasks) {
        if (tasks.isEmpty) {
          return const Text('No tasks yet.');
        }
        return Column(
          children: tasks
              .map(
                (task) => CheckboxListTile(
                  value: task.isDone,
                  onChanged: (_) => context.read<TasksCubit>().toggle(task.id),
                  title: Text(
                    task.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  secondary: Icon(task.isDone ? Icons.check_circle : Icons.radio_button_unchecked),
                ),
              )
              .toList(growable: false),
        );
      },
    );
  }
}

class _NetworkStatus extends StatelessWidget {
  const _NetworkStatus();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkCubit, NetworkState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.error != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Failed to load demo payload', style: Theme.of(context).textTheme.titleMedium),
              Text(
                state.error ?? '',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              FilledButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Try again'),
                onPressed: () => context.read<NetworkCubit>().loadExample(),
              ),
            ],
          );
        }

        final payload = state.data;
        if (payload == null) {
          return const Text('No payload yet, tap refresh.');
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              children: [
                Chip(label: Text('User ${payload.userId}')),
                Chip(label: Text('ID ${payload.id}')),
                Chip(
                  label: Text(payload.completed ? 'Completed' : 'Open'),
                  backgroundColor:
                      payload.completed ? Colors.green.withOpacity(0.2) : Colors.orange.withOpacity(0.2),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              payload.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        );
      },
    );
  }
}

class _HeroHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withOpacity(0.14),
            theme.colorScheme.secondary.withOpacity(0.12),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.auto_awesome, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Build faster with Melos', style: theme.textTheme.titleLarge),
                const SizedBox(height: 4),
                Text(
                  'DI, navigation, Retrofit, and themed UI bundled as a modular workspace.',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
