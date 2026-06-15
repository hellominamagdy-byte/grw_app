import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.light;

  bool get isDark => state == ThemeMode.dark;

  void setDark(bool enabled) {
    state = enabled ? ThemeMode.dark : ThemeMode.light;
  }

  void toggle() {
    setDark(!isDark);
  }
}
