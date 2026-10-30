import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cache/cache_helper.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit()
      : super(
          CacheHelper.getThemeMode()
              ? ThemeMode.dark
              : ThemeMode.light,
        );

  void toggleTheme() {
    final newTheme =
        state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;

    emit(newTheme);
    CacheHelper.setThemeMode(newTheme == ThemeMode.dark);
  }

  void setTheme(ThemeMode themeMode) {
    emit(themeMode);
    CacheHelper.setThemeMode(themeMode == ThemeMode.dark);
  }
}