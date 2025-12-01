import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:networking/networking.dart';

import 'cubits/network_cubit.dart';
import 'cubits/tasks_cubit.dart';
import 'cubits/theme_cubit.dart';
import 'views/details_page.dart';
import 'views/home_page.dart';

class MelosShowcaseApp extends StatelessWidget {
  const MelosShowcaseApp({super.key, this.exampleFetcher});

  final ExampleFetcher? exampleFetcher;

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: HomePage.routeName,
      routes: [
        GoRoute(
          path: HomePage.routeName,
          name: HomePage.routeName,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: DetailsPage.routeName,
          name: DetailsPage.routeName,
          builder: (context, state) => const DetailsPage(),
        ),
      ],
    );

    final ExampleFetcher fetcher = exampleFetcher ?? sl<ExampleFetcher>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TasksCubit(sl<TasksRepository>())),
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider<NetworkCubit>(
          create: (_) => NetworkCubit(fetcher)..loadExample(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: 'Melos Showcase',
            themeMode: themeMode,
            theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
            darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
            routerConfig: router,
          );
        },
      ),
    );
  }
}
