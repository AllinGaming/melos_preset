import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void toggle() {
    final next = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(next);
  }

  void set(ThemeMode mode) => emit(mode);
}
