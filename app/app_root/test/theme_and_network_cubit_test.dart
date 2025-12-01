import 'package:app_root/src/cubits/network_cubit.dart';
import 'package:app_root/src/cubits/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:networking/networking.dart';

class _FailingFetcher implements ExampleFetcher {
  @override
  Future<ExampleResponse> fetchExample() async {
    throw Exception('boom');
  }
}

class _SucceedingFetcher implements ExampleFetcher {
  const _SucceedingFetcher();
  @override
  Future<ExampleResponse> fetchExample() async => const ExampleResponse(
        userId: 1,
        id: 1,
        title: 'ok',
        completed: true,
      );
}

void main() {
  test('ThemeCubit toggles and sets', () {
    final cubit = ThemeCubit();
    expect(cubit.state, ThemeMode.system);
    cubit.set(ThemeMode.light);
    expect(cubit.state, ThemeMode.light);
    cubit.toggle();
    expect(cubit.state, ThemeMode.dark);
  });

  test('NetworkCubit success populates data', () async {
    final cubit = NetworkCubit(const _SucceedingFetcher());
    await cubit.loadExample();
    expect(cubit.state.data?.title, 'ok');
  });

  test('NetworkCubit captures error', () async {
    final cubit = NetworkCubit(_FailingFetcher());
    await cubit.loadExample();
    expect(cubit.state.error, contains('boom'));
    expect(cubit.state.isLoading, isFalse);
  });
}
